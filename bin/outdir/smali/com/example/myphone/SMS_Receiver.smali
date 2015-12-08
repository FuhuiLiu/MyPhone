.class public Lcom/example/myphone/SMS_Receiver;
.super Landroid/content/BroadcastReceiver;
.source "SMS_Receiver.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "MyPhone"


# instance fields
.field public final DEBUG:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 16
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    .line 18
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/example/myphone/SMS_Receiver;->DEBUG:Z

    .line 16
    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 20
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 23
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    .line 25
    .local v13, "sb":Ljava/lang/StringBuilder;
    invoke-virtual/range {p2 .. p2}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v3

    .line 27
    .local v3, "bundle":Landroid/os/Bundle;
    if-eqz v3, :cond_0

    .line 32
    const-string v16, "pdus"

    move-object/from16 v0, v16

    invoke-virtual {v3, v0}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, [Ljava/lang/Object;

    .line 34
    .local v11, "myOBJpdus":[Ljava/lang/Object;
    array-length v0, v11

    move/from16 v16, v0

    move/from16 v0, v16

    new-array v10, v0, [Landroid/telephony/SmsMessage;

    .line 35
    .local v10, "messages":[Landroid/telephony/SmsMessage;
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_0
    array-length v0, v11

    move/from16 v16, v0

    move/from16 v0, v16

    if-lt v7, v0, :cond_1

    .line 42
    array-length v0, v10

    move/from16 v17, v0

    const/16 v16, 0x0

    :goto_1
    move/from16 v0, v16

    move/from16 v1, v17

    if-lt v0, v1, :cond_2

    .line 76
    .end local v7    # "i":I
    .end local v10    # "messages":[Landroid/telephony/SmsMessage;
    .end local v11    # "myOBJpdus":[Ljava/lang/Object;
    :cond_0
    const-string v16, "MyPhone"

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v17

    invoke-static/range {v16 .. v17}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 77
    return-void

    .line 36
    .restart local v7    # "i":I
    .restart local v10    # "messages":[Landroid/telephony/SmsMessage;
    .restart local v11    # "myOBJpdus":[Ljava/lang/Object;
    :cond_1
    aget-object v16, v11, v7

    check-cast v16, [B

    invoke-static/range {v16 .. v16}, Landroid/telephony/SmsMessage;->createFromPdu([B)Landroid/telephony/SmsMessage;

    move-result-object v16

    aput-object v16, v10, v7

    .line 35
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 42
    :cond_2
    aget-object v4, v10, v16

    .line 45
    .local v4, "currentMessage":Landroid/telephony/SmsMessage;
    new-instance v18, Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Landroid/telephony/SmsMessage;->getDisplayOriginatingAddress()Ljava/lang/String;

    move-result-object v19

    invoke-static/range {v19 .. v19}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v19

    invoke-direct/range {v18 .. v19}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 46
    const-string v19, "+"

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    .line 45
    move-object/from16 v0, v18

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 48
    new-instance v18, Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Landroid/telephony/SmsMessage;->getDisplayMessageBody()Ljava/lang/String;

    move-result-object v19

    invoke-static/range {v19 .. v19}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v19

    invoke-direct/range {v18 .. v19}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v19, "+"

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 50
    invoke-virtual {v4}, Landroid/telephony/SmsMessage;->getTimestampMillis()J

    move-result-wide v8

    .line 51
    .local v8, "lDate":J
    new-instance v18, Ljava/lang/StringBuilder;

    invoke-static {v8, v9}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v19

    invoke-direct/range {v18 .. v19}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v19, "+"

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 53
    new-instance v5, Ljava/sql/Date;

    invoke-direct {v5, v8, v9}, Ljava/sql/Date;-><init>(J)V

    .line 55
    .local v5, "date":Ljava/sql/Date;
    new-instance v14, Ljava/text/SimpleDateFormat;

    const-string v18, "yyyy-MM-dd hh:mm:ss"

    move-object/from16 v0, v18

    invoke-direct {v14, v0}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    .line 56
    .local v14, "sdf":Ljava/text/SimpleDateFormat;
    invoke-virtual {v14, v5}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v15

    .line 57
    .local v15, "strdate":Ljava/lang/String;
    new-instance v18, Ljava/lang/StringBuilder;

    invoke-static {v15}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v19

    invoke-direct/range {v18 .. v19}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v19, "+"

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 60
    invoke-virtual {v4}, Landroid/telephony/SmsMessage;->getProtocolIdentifier()I

    move-result v12

    .line 61
    .local v12, "nProtocol":I
    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 63
    sget-object v18, Lcom/example/myphone/MainActivity;->objPhone:Lcom/example/myphone/CPhone;

    if-eqz v18, :cond_3

    .line 66
    :try_start_0
    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    const-string v19, "gbk"

    invoke-virtual/range {v18 .. v19}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    .line 67
    .local v2, "bArry":[B
    sget-object v18, Lcom/example/myphone/MainActivity;->objPhone:Lcom/example/myphone/CPhone;

    .line 68
    array-length v0, v2

    move/from16 v19, v0

    .line 67
    move-object/from16 v0, v18

    move/from16 v1, v19

    invoke-virtual {v0, v2, v1}, Lcom/example/myphone/CPhone;->SendNewInSms([BI)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 42
    .end local v2    # "bArry":[B
    :cond_3
    :goto_2
    add-int/lit8 v16, v16, 0x1

    goto/16 :goto_1

    .line 69
    :catch_0
    move-exception v6

    .line 70
    .local v6, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v6}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_2
.end method
