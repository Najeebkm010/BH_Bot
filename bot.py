import discord
from discord.ext import commands
import subprocess
import os

TOKEN = 'You Discode Tocken'
MAX_MESSAGE_LENGTH = 2000

intents = discord.Intents.default()
intents.message_content = True  # Enable the message content intent

bot = commands.Bot(command_prefix='!', intents=intents)

@bot.event
async def on_ready():
    print(f'We have logged in as {bot.user}')

@bot.command()
async def subs(ctx, domain: str):
    """Command to run subfinder and save results to a file"""
    subfinder_file = 'subfinder_results.txt'

    # Run subfinder and save results to a file
    try:
        with open(subfinder_file, 'w') as file:
            subfinder_process = subprocess.Popen(['./subfinder_scan.sh', domain], stdout=file, stderr=subprocess.PIPE)
            _, stderr = subfinder_process.communicate()
            if stderr:
                file.write("Errors:\n" + stderr.decode())
    except Exception as e:
        await ctx.send(f"Error running subfinder: {str(e)}")
        return

    # Send the subfinder results file
    try:
        with open(subfinder_file, 'rb') as file:
            await ctx.send(file=discord.File(file, subfinder_file))
    except Exception as e:
        await ctx.send(f"Error sending subfinder results file: {str(e)}")
    finally:
        # Clean up the file
        if os.path.exists(subfinder_file):
            os.remove(subfinder_file)

@bot.command()
async def nf(ctx, domain: str):
    """Command to run nf with a domain and send results"""
    nf_file = 'nf_results.txt'

    # Run nf with the domain
    try:
        with open(nf_file, 'w') as file:
            nf_process = subprocess.Popen(['./nf_scan.sh', domain], stdout=file, stderr=subprocess.PIPE)
            _, stderr = nf_process.communicate()
            if stderr:
                file.write("Errors:\n" + stderr.decode())
    except Exception as e:
        await ctx.send(f"Error running nf: {str(e)}")
        return

    # Check the size of the result file and either send it as text or as a file
    try:
        with open(nf_file, 'r') as file:
            nf_result = file.read()
            if len(nf_result) <= MAX_MESSAGE_LENGTH:
                await ctx.send(f"Results for `{domain}`:\n```{nf_result}```")
            else:
                await ctx.send(file=discord.File(nf_file))
    except Exception as e:
        await ctx.send(f"Error sending nf results: {str(e)}")
    finally:
        # Clean up the file
        if os.path.exists(nf_file):
            os.remove(nf_file)

@bot.command()
async def port(ctx, domain: str):
    """Command to run nmap and send results as a file"""
    result_file = 'nmap_results.txt'

    # Run nmap and save results to a file
    try:
        with open(result_file, 'w') as file:
            nmap_process = subprocess.Popen(['./nmap_scan.sh', domain], stdout=file, stderr=subprocess.PIPE)
            _, stderr = nmap_process.communicate()
            if stderr:
                file.write("Errors:\n" + stderr.decode())
    except Exception as e:
        await ctx.send(f"Error running nmap: {str(e)}")
        return

    # Send the file in a Discord message
    try:
        with open(result_file, 'rb') as file:
            await ctx.send(file=discord.File(file, result_file))
    except Exception as e:
        await ctx.send(f"Error sending file: {str(e)}")
    finally:
        # Clean up the file
        if os.path.exists(result_file):
            os.remove(result_file)

bot.run(TOKEN)
