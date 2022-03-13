import telebot
import drawing
# import socket
# clientsocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# clientsocket.connect(('192.168.1.86', 2000))
#https://t.me/pixelControlbot
draw = drawing.Draw(8080)
bot = telebot.TeleBot('2057090131:AAG20n8dEIht5Kj9jkAAX9cWVY44K_g4qI8')
whiteID = [-1001712435344]

@bot.message_handler(commands=['set'])
def setCm(ms):
    print(ms)
    if ms.chat.id not in whiteID:
        return
    #/set x y
    try:
        cm = ms.text.split(' ')
        x = cm[1]
        y = cm[2]
    except Exception:
        bot.send_message(ms.chat.id, 'Invalid command')
        return
    draw.set(x, y)


@bot.message_handler(commands=['clr'])
def clrCm(ms):
    #/set x ys
    print(ms)
    if ms.chat.id not in whiteID:
        return
    try:
        cm = ms.text.split(' ')
        x = cm[1]
        y = cm[2]
    except Exception:
        bot.send_message(ms.chat.id, 'Invalid command')
        return
    draw.clear(x, y)


bot.polling()
