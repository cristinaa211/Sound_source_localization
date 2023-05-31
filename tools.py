import pywt
import smtplib
import matplotlib.pyplot as plt


def wavelet(s1):
    coeffs2 = pywt.dwt2(s1, 'bior1.3')
    LL, (LH, HL, HH) = coeffs2
    fig  = plt.figure()
    for i, a in enumerate([LL, LH, HL, HH]):
        ax = fig.add_subplot(1, 4, i + 1)
        ax.imshow(a, interpolation="nearest", cmap=plt.cm.gray)
        ax.set_xticks([])
        ax.set_yticks([])
    fig.tight_layout()
    plt.show()
    


def email(sender, rec, passw, msg):
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(sender, passw)
    print('Login success')
    server.sendmail(sender,rec, msg)
    print('Email has been sent to rec')
    return 1
    
def bytes_to_int(caractere):
    result = 0
    for b in caractere:
        result = result * 256 + ord((b))
    return result