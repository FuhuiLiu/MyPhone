.class public Lcom/example/myphone/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"


# static fields
.field public static MainThis:Lcom/example/myphone/MainActivity;

.field public static objPhone:Lcom/example/myphone/CPhone;


# instance fields
.field btnStart:Landroid/widget/Button;

.field public sbs:Lcom/example/myphone/SmsObserver;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 21
    const/4 v0, 0x0

    sput-object v0, Lcom/example/myphone/MainActivity;->objPhone:Lcom/example/myphone/CPhone;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 19
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 23
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/example/myphone/MainActivity;->btnStart:Landroid/widget/Button;

    .line 19
    return-void
.end method

.method public static GetInstance()Lcom/example/myphone/MainActivity;
    .locals 1

    .prologue
    .line 54
    sget-object v0, Lcom/example/myphone/MainActivity;->MainThis:Lcom/example/myphone/MainActivity;

    return-object v0
.end method


# virtual methods
.method public GetInfo()V
    .locals 4

    .prologue
    .line 63
    new-instance v0, Lcom/example/myphone/PhoneInfo;

    invoke-direct {v0}, Lcom/example/myphone/PhoneInfo;-><init>()V

    .line 64
    .local v0, "siminfo":Lcom/example/myphone/PhoneInfo;
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "getProvidersName:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/example/myphone/PhoneInfo;->getProvidersName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 65
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "getNativePhoneNumber:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/example/myphone/PhoneInfo;->getNativePhoneNumber()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 66
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "------------------------"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 67
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "getPhoneInfo:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/example/myphone/PhoneInfo;->getPhoneInfo()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 69
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Phone Model: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/example/myphone/PhoneInfo;->getModel()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " Version:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Lcom/example/myphone/PhoneInfo;->getVersion()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 70
    return-void
.end method

.method public GetIpAddr()V
    .locals 4

    .prologue
    .line 75
    :try_start_0
    invoke-static {}, Ljava/net/InetAddress;->getLocalHost()Ljava/net/InetAddress;

    move-result-object v1

    .line 76
    .local v1, "ia":Ljava/net/InetAddress;
    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v2

    .line 77
    .local v2, "ip":Ljava/lang/String;
    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v3, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0

    .line 81
    .end local v1    # "ia":Ljava/net/InetAddress;
    .end local v2    # "ip":Ljava/lang/String;
    :goto_0
    return-void

    .line 78
    :catch_0
    move-exception v0

    .line 79
    .local v0, "e":Ljava/net/UnknownHostException;
    invoke-virtual {v0}, Ljava/net/UnknownHostException;->printStackTrace()V

    goto :goto_0
.end method

.method public SayHello()V
    .locals 2

    .prologue
    .line 58
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "SayHello"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 59
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 26
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 27
    const/high16 v0, 0x7f030000

    invoke-virtual {p0, v0}, Lcom/example/myphone/MainActivity;->setContentView(I)V

    .line 28
    sput-object p0, Lcom/example/myphone/MainActivity;->MainThis:Lcom/example/myphone/MainActivity;

    .line 29
    new-instance v0, Lcom/example/myphone/SmsObserver;

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    invoke-direct {v0, v1}, Lcom/example/myphone/SmsObserver;-><init>(Landroid/os/Handler;)V

    iput-object v0, p0, Lcom/example/myphone/MainActivity;->sbs:Lcom/example/myphone/SmsObserver;

    .line 30
    invoke-virtual {p0}, Lcom/example/myphone/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 31
    const-string v1, "content://sms"

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    .line 32
    const/4 v2, 0x1

    iget-object v3, p0, Lcom/example/myphone/MainActivity;->sbs:Lcom/example/myphone/SmsObserver;

    .line 30
    invoke-virtual {v0, v1, v2, v3}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 33
    invoke-static {}, Lcom/example/myphone/CPhone;->foo()V

    .line 35
    const v0, 0x7f060001

    invoke-virtual {p0, v0}, Lcom/example/myphone/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/example/myphone/MainActivity;->btnStart:Landroid/widget/Button;

    .line 37
    iget-object v0, p0, Lcom/example/myphone/MainActivity;->btnStart:Landroid/widget/Button;

    new-instance v1, Lcom/example/myphone/MainActivity$1;

    invoke-direct {v1, p0}, Lcom/example/myphone/MainActivity$1;-><init>(Lcom/example/myphone/MainActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 44
    return-void
.end method

.method protected onDestroy()V
    .locals 2

    .prologue
    .line 48
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 49
    invoke-virtual {p0}, Lcom/example/myphone/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    iget-object v1, p0, Lcom/example/myphone/MainActivity;->sbs:Lcom/example/myphone/SmsObserver;

    invoke-virtual {v0, v1}, Landroid/content/ContentResolver;->unregisterContentObserver(Landroid/database/ContentObserver;)V

    .line 50
    return-void
.end method
