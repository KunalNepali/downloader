import yt_dlp

url = 'https://www.youtube.com/watch?v=r3yzJ86SK6I'

options = {
    'format': 'bestaudio/best',
    'outtmpl': '%(title)s.%(ext)s',
    'postprocessors': [{
        'key': 'FFmpegExtractAudio',
        'preferredcodec': 'mp3',
        'preferredquality': '192',
    }],
}

with yt_dlp.YoutubeDL(options) as ydl:
    ydl.download([url])
    print("Download completed successfully.")
    