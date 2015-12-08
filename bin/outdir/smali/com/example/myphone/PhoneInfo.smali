.class public Lcom/example/myphone/PhoneInfo;
.super Ljava/lang/Object;
.source "PhoneInfo.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "MyPhone"


# instance fields
.field private final DEBUG:Z

.field private IMSI:Ljava/lang/String;

.field private cxt:Landroid/content/Context;

.field private telephonyManager:Landroid/telephony/TelephonyManager;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/example/myphone/PhoneInfo;->DEBUG:Z

    .line 41
    invoke-static {}, Lcom/example/myphone/MainActivity;->GetInstance()Lcom/example/myphone/MainActivity;

    move-result-object v0

    iput-object v0, p0, Lcom/example/myphone/PhoneInfo;->cxt:Landroid/content/Context;

    .line 42
    iget-object v0, p0, Lcom/example/myphone/PhoneInfo;->cxt:Landroid/content/Context;

    .line 43
    const-string v1, "phone"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 42
    iput-object v0, p0, Lcom/example/myphone/PhoneInfo;->telephonyManager:Landroid/telephony/TelephonyManager;

    .line 44
    return-void
.end method

.method public static GetNetIp()Ljava/lang/String;
    .locals 17

    .prologue
    .line 349
    const/4 v5, 0x0

    .line 350
    .local v5, "infoUrl":Ljava/net/URL;
    const/4 v4, 0x0

    .line 351
    .local v4, "inStream":Ljava/io/InputStream;
    const-string v7, ""

    .line 352
    .local v7, "ipLine":Ljava/lang/String;
    const/4 v3, 0x0

    .line 354
    .local v3, "httpConnection":Ljava/net/HttpURLConnection;
    :try_start_0
    new-instance v6, Ljava/net/URL;

    const-string v15, "http://www.ip168.com/"

    invoke-direct {v6, v15}, Ljava/net/URL;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_7
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 355
    .end local v5    # "infoUrl":Ljava/net/URL;
    .local v6, "infoUrl":Ljava/net/URL;
    :try_start_1
    invoke-virtual {v6}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v1

    .line 356
    .local v1, "connection":Ljava/net/URLConnection;
    move-object v0, v1

    check-cast v0, Ljava/net/HttpURLConnection;

    move-object v3, v0

    .line 357
    const/16 v15, 0x2710

    invoke-virtual {v3, v15}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 358
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v13

    .line 359
    .local v13, "responseCode":I
    const/16 v15, 0xc8

    if-ne v13, v15, :cond_0

    .line 360
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v4

    .line 361
    new-instance v12, Ljava/io/BufferedReader;

    .line 362
    new-instance v15, Ljava/io/InputStreamReader;

    const-string v16, "utf-8"

    move-object/from16 v0, v16

    invoke-direct {v15, v4, v0}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    .line 361
    invoke-direct {v12, v15}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 363
    .local v12, "reader":Ljava/io/BufferedReader;
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    .line 364
    .local v14, "strber":Ljava/lang/StringBuilder;
    const/4 v8, 0x0

    .line 365
    .local v8, "line":Ljava/lang/String;
    :goto_0
    invoke-virtual {v12}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v8

    if-nez v8, :cond_1

    .line 368
    const/4 v10, 0x0

    .line 370
    .local v10, "n":I
    const-string v15, "((?:(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d)))\\.){3}(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d))))"

    invoke-static {v15}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v11

    .line 371
    .local v11, "pattern":Ljava/util/regex/Pattern;
    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v11, v15}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v9

    .line 372
    .local v9, "matcher":Ljava/util/regex/Matcher;
    invoke-virtual {v9}, Ljava/util/regex/Matcher;->find()Z

    move-result v15

    if-eqz v15, :cond_0

    .line 373
    invoke-virtual {v9}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;
    :try_end_1
    .catch Ljava/net/MalformedURLException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-object v7

    .line 383
    .end local v8    # "line":Ljava/lang/String;
    .end local v9    # "matcher":Ljava/util/regex/Matcher;
    .end local v10    # "n":I
    .end local v11    # "pattern":Ljava/util/regex/Pattern;
    .end local v12    # "reader":Ljava/io/BufferedReader;
    .end local v14    # "strber":Ljava/lang/StringBuilder;
    :cond_0
    :try_start_2
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    .line 384
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_5

    move-object v5, v6

    .line 389
    .end local v1    # "connection":Ljava/net/URLConnection;
    .end local v6    # "infoUrl":Ljava/net/URL;
    .end local v13    # "responseCode":I
    .restart local v5    # "infoUrl":Ljava/net/URL;
    :goto_1
    return-object v7

    .line 366
    .end local v5    # "infoUrl":Ljava/net/URL;
    .restart local v1    # "connection":Ljava/net/URLConnection;
    .restart local v6    # "infoUrl":Ljava/net/URL;
    .restart local v8    # "line":Ljava/lang/String;
    .restart local v12    # "reader":Ljava/io/BufferedReader;
    .restart local v13    # "responseCode":I
    .restart local v14    # "strber":Ljava/lang/StringBuilder;
    :cond_1
    :try_start_3
    new-instance v15, Ljava/lang/StringBuilder;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v16

    invoke-direct/range {v15 .. v16}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v16, "\n"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_3
    .catch Ljava/net/MalformedURLException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_6
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_0

    .line 377
    .end local v1    # "connection":Ljava/net/URLConnection;
    .end local v8    # "line":Ljava/lang/String;
    .end local v12    # "reader":Ljava/io/BufferedReader;
    .end local v13    # "responseCode":I
    .end local v14    # "strber":Ljava/lang/StringBuilder;
    :catch_0
    move-exception v2

    move-object v5, v6

    .line 378
    .end local v6    # "infoUrl":Ljava/net/URL;
    .local v2, "e":Ljava/net/MalformedURLException;
    .restart local v5    # "infoUrl":Ljava/net/URL;
    :goto_2
    :try_start_4
    invoke-virtual {v2}, Ljava/net/MalformedURLException;->printStackTrace()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 383
    :try_start_5
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    .line 384
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_1

    goto :goto_1

    .line 385
    :catch_1
    move-exception v2

    .line 386
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 379
    .end local v2    # "e":Ljava/io/IOException;
    :catch_2
    move-exception v2

    .line 380
    .restart local v2    # "e":Ljava/io/IOException;
    :goto_3
    :try_start_6
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 383
    :try_start_7
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    .line 384
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_3

    goto :goto_1

    .line 385
    :catch_3
    move-exception v2

    .line 386
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 381
    .end local v2    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v15

    .line 383
    :goto_4
    :try_start_8
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    .line 384
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_4

    .line 388
    :goto_5
    throw v15

    .line 385
    :catch_4
    move-exception v2

    .line 386
    .restart local v2    # "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_5

    .line 385
    .end local v2    # "e":Ljava/io/IOException;
    .end local v5    # "infoUrl":Ljava/net/URL;
    .restart local v1    # "connection":Ljava/net/URLConnection;
    .restart local v6    # "infoUrl":Ljava/net/URL;
    .restart local v13    # "responseCode":I
    :catch_5
    move-exception v2

    .line 386
    .restart local v2    # "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    move-object v5, v6

    .end local v6    # "infoUrl":Ljava/net/URL;
    .restart local v5    # "infoUrl":Ljava/net/URL;
    goto :goto_1

    .line 381
    .end local v1    # "connection":Ljava/net/URLConnection;
    .end local v2    # "e":Ljava/io/IOException;
    .end local v5    # "infoUrl":Ljava/net/URL;
    .end local v13    # "responseCode":I
    .restart local v6    # "infoUrl":Ljava/net/URL;
    :catchall_1
    move-exception v15

    move-object v5, v6

    .end local v6    # "infoUrl":Ljava/net/URL;
    .restart local v5    # "infoUrl":Ljava/net/URL;
    goto :goto_4

    .line 379
    .end local v5    # "infoUrl":Ljava/net/URL;
    .restart local v6    # "infoUrl":Ljava/net/URL;
    :catch_6
    move-exception v2

    move-object v5, v6

    .end local v6    # "infoUrl":Ljava/net/URL;
    .restart local v5    # "infoUrl":Ljava/net/URL;
    goto :goto_3

    .line 377
    :catch_7
    move-exception v2

    goto :goto_2
.end method

.method public static GetNetIp2()Ljava/lang/String;
    .locals 15

    .prologue
    .line 395
    const/4 v6, 0x0

    .line 396
    .local v6, "infoUrl":Ljava/net/URL;
    const/4 v5, 0x0

    .line 401
    .local v5, "inStream":Ljava/io/InputStream;
    :try_start_0
    new-instance v7, Ljava/net/URL;

    const-string v13, "http://iframe.ip138.com/ic.asp"

    invoke-direct {v7, v13}, Ljava/net/URL;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 402
    .end local v6    # "infoUrl":Ljava/net/URL;
    .local v7, "infoUrl":Ljava/net/URL;
    :try_start_1
    invoke-virtual {v7}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v1

    .line 403
    .local v1, "connection":Ljava/net/URLConnection;
    move-object v0, v1

    check-cast v0, Ljava/net/HttpURLConnection;

    move-object v4, v0

    .line 404
    .local v4, "httpConnection":Ljava/net/HttpURLConnection;
    invoke-virtual {v4}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v10

    .line 405
    .local v10, "responseCode":I
    const/16 v13, 0xc8

    if-ne v10, v13, :cond_1

    .line 407
    invoke-virtual {v4}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    .line 408
    new-instance v9, Ljava/io/BufferedReader;

    new-instance v13, Ljava/io/InputStreamReader;

    const-string v14, "utf-8"

    invoke-direct {v13, v5, v14}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v9, v13}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 409
    .local v9, "reader":Ljava/io/BufferedReader;
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    .line 410
    .local v12, "strber":Ljava/lang/StringBuilder;
    const/4 v8, 0x0

    .line 411
    .local v8, "line":Ljava/lang/String;
    :goto_0
    invoke-virtual {v9}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v8

    if-nez v8, :cond_0

    .line 413
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    .line 415
    const-string v13, "["

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->indexOf(Ljava/lang/String;)I

    move-result v11

    .line 416
    .local v11, "start":I
    const-string v13, "]"

    add-int/lit8 v14, v11, 0x1

    invoke-virtual {v12, v13, v14}, Ljava/lang/StringBuilder;->indexOf(Ljava/lang/String;I)I

    move-result v3

    .line 417
    .local v3, "end":I
    add-int/lit8 v13, v11, 0x1

    invoke-virtual {v12, v13, v3}, Ljava/lang/StringBuilder;->substring(II)Ljava/lang/String;

    move-result-object v8

    .line 427
    .end local v1    # "connection":Ljava/net/URLConnection;
    .end local v3    # "end":I
    .end local v4    # "httpConnection":Ljava/net/HttpURLConnection;
    .end local v7    # "infoUrl":Ljava/net/URL;
    .end local v8    # "line":Ljava/lang/String;
    .end local v9    # "reader":Ljava/io/BufferedReader;
    .end local v10    # "responseCode":I
    .end local v11    # "start":I
    .end local v12    # "strber":Ljava/lang/StringBuilder;
    :goto_1
    return-object v8

    .line 412
    .restart local v1    # "connection":Ljava/net/URLConnection;
    .restart local v4    # "httpConnection":Ljava/net/HttpURLConnection;
    .restart local v7    # "infoUrl":Ljava/net/URL;
    .restart local v8    # "line":Ljava/lang/String;
    .restart local v9    # "reader":Ljava/io/BufferedReader;
    .restart local v10    # "responseCode":I
    .restart local v12    # "strber":Ljava/lang/StringBuilder;
    :cond_0
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v14

    invoke-direct {v13, v14}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v14, "\n"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_1
    .catch Ljava/net/MalformedURLException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2

    goto :goto_0

    .line 421
    .end local v1    # "connection":Ljava/net/URLConnection;
    .end local v4    # "httpConnection":Ljava/net/HttpURLConnection;
    .end local v8    # "line":Ljava/lang/String;
    .end local v9    # "reader":Ljava/io/BufferedReader;
    .end local v10    # "responseCode":I
    .end local v12    # "strber":Ljava/lang/StringBuilder;
    :catch_0
    move-exception v2

    move-object v6, v7

    .line 422
    .end local v7    # "infoUrl":Ljava/net/URL;
    .local v2, "e":Ljava/net/MalformedURLException;
    .restart local v6    # "infoUrl":Ljava/net/URL;
    :goto_2
    invoke-virtual {v2}, Ljava/net/MalformedURLException;->printStackTrace()V

    .line 427
    .end local v2    # "e":Ljava/net/MalformedURLException;
    :goto_3
    const/4 v8, 0x0

    goto :goto_1

    .line 424
    :catch_1
    move-exception v2

    .line 425
    .local v2, "e":Ljava/io/IOException;
    :goto_4
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3

    .line 424
    .end local v2    # "e":Ljava/io/IOException;
    .end local v6    # "infoUrl":Ljava/net/URL;
    .restart local v7    # "infoUrl":Ljava/net/URL;
    :catch_2
    move-exception v2

    move-object v6, v7

    .end local v7    # "infoUrl":Ljava/net/URL;
    .restart local v6    # "infoUrl":Ljava/net/URL;
    goto :goto_4

    .line 421
    :catch_3
    move-exception v2

    goto :goto_2

    .end local v6    # "infoUrl":Ljava/net/URL;
    .restart local v1    # "connection":Ljava/net/URLConnection;
    .restart local v4    # "httpConnection":Ljava/net/HttpURLConnection;
    .restart local v7    # "infoUrl":Ljava/net/URL;
    .restart local v10    # "responseCode":I
    :cond_1
    move-object v6, v7

    .end local v7    # "infoUrl":Ljava/net/URL;
    .restart local v6    # "infoUrl":Ljava/net/URL;
    goto :goto_3
.end method


# virtual methods
.method public GetAllSmsMsg(J)V
    .locals 35
    .param p1, "lQueryMinDate"    # J

    .prologue
    .line 133
    const-string v5, "MyPhone"

    const-string v6, "GetAllSmsMsg"

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 135
    const-string v8, "content://sms/"

    .line 137
    .local v8, "SMS_URI_ALL":Ljava/lang/String;
    new-instance v29, Ljava/lang/StringBuilder;

    invoke-direct/range {v29 .. v29}, Ljava/lang/StringBuilder;-><init>()V

    .line 139
    .local v29, "smsFormat":Ljava/lang/StringBuilder;
    new-instance v28, Ljava/lang/StringBuilder;

    invoke-direct/range {v28 .. v28}, Ljava/lang/StringBuilder;-><init>()V

    .line 142
    .local v28, "smsAll":Ljava/lang/StringBuilder;
    :try_start_0
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/example/myphone/PhoneInfo;->cxt:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    .line 144
    .local v2, "cr":Landroid/content/ContentResolver;
    const/4 v5, 0x7

    new-array v4, v5, [Ljava/lang/String;

    const/4 v5, 0x0

    const-string v6, "_id"

    aput-object v6, v4, v5

    const/4 v5, 0x1

    const-string v6, "address"

    aput-object v6, v4, v5

    const/4 v5, 0x2

    const-string v6, "person"

    aput-object v6, v4, v5

    const/4 v5, 0x3

    const-string v6, "body"

    aput-object v6, v4, v5

    const/4 v5, 0x4

    .line 145
    const-string v6, "date"

    aput-object v6, v4, v5

    const/4 v5, 0x5

    const-string v6, "type"

    aput-object v6, v4, v5

    const/4 v5, 0x6

    const-string v6, "protocol"

    aput-object v6, v4, v5

    .line 146
    .local v4, "projection":[Ljava/lang/String;
    const-string v5, "content://sms/"

    invoke-static {v5}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    .line 148
    .local v3, "uri":Landroid/net/Uri;
    const/4 v5, 0x0

    const/4 v6, 0x0

    const-string v7, "date asc"

    invoke-virtual/range {v2 .. v7}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v10

    .line 149
    .local v10, "cur":Landroid/database/Cursor;
    invoke-interface {v10}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v5

    if-eqz v5, :cond_0

    .line 157
    const-string v5, "person"

    invoke-interface {v10, v5}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v24

    .line 158
    .local v24, "nameColumn":I
    const-string v5, "address"

    invoke-interface {v10, v5}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v26

    .line 159
    .local v26, "phoneNumberColumn":I
    const-string v5, "body"

    invoke-interface {v10, v5}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v31

    .line 160
    .local v31, "smsbodyColumn":I
    const-string v5, "date"

    invoke-interface {v10, v5}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v13

    .line 161
    .local v13, "dateColumn":I
    const-string v5, "type"

    invoke-interface {v10, v5}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v32

    .line 162
    .local v32, "typeColumn":I
    const-string v5, "protocol"

    invoke-interface {v10, v5}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v27

    .line 165
    .local v27, "protocolColumn":I
    const/16 v17, 0x0

    .line 167
    .local v17, "nCount":I
    const-wide/16 v20, 0x0

    .line 168
    .local v20, "lMaxDate":J
    invoke-interface {v10}, Landroid/database/Cursor;->moveToLast()Z

    .line 169
    invoke-interface {v10, v13}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v20

    .line 170
    invoke-interface {v10}, Landroid/database/Cursor;->moveToFirst()Z

    .line 172
    cmp-long v5, v20, p1

    if-gtz v5, :cond_1

    .line 175
    const-string v5, "MyPhone"

    const-string v6, "lMaxDate <= lQueryMinDate"

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 241
    .end local v2    # "cr":Landroid/content/ContentResolver;
    .end local v3    # "uri":Landroid/net/Uri;
    .end local v4    # "projection":[Ljava/lang/String;
    .end local v10    # "cur":Landroid/database/Cursor;
    .end local v13    # "dateColumn":I
    .end local v17    # "nCount":I
    .end local v20    # "lMaxDate":J
    .end local v24    # "nameColumn":I
    .end local v26    # "phoneNumberColumn":I
    .end local v27    # "protocolColumn":I
    .end local v31    # "smsbodyColumn":I
    .end local v32    # "typeColumn":I
    :cond_0
    :goto_0
    return-void

    .line 182
    .restart local v2    # "cr":Landroid/content/ContentResolver;
    .restart local v3    # "uri":Landroid/net/Uri;
    .restart local v4    # "projection":[Ljava/lang/String;
    .restart local v10    # "cur":Landroid/database/Cursor;
    .restart local v13    # "dateColumn":I
    .restart local v17    # "nCount":I
    .restart local v20    # "lMaxDate":J
    .restart local v24    # "nameColumn":I
    .restart local v26    # "phoneNumberColumn":I
    .restart local v27    # "protocolColumn":I
    .restart local v31    # "smsbodyColumn":I
    .restart local v32    # "typeColumn":I
    :cond_1
    invoke-interface {v10, v13}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v18

    .line 183
    .local v18, "lCurSmsDate":J
    cmp-long v5, v18, p1

    if-gtz v5, :cond_3

    .line 216
    :cond_2
    :goto_1
    invoke-interface {v10}, Landroid/database/Cursor;->moveToNext()Z

    move-result v5

    if-nez v5, :cond_1

    .line 218
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v0, v17

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "$"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v29

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 219
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-static/range {v20 .. v21}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v6, "$"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v29

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 220
    move-object/from16 v0, v29

    move-object/from16 v1, v28

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/CharSequence;)Ljava/lang/StringBuilder;

    .line 223
    const-string v5, "MyPhone"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-virtual/range {v29 .. v29}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v7, "\n"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 224
    invoke-virtual/range {v29 .. v29}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 223
    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 226
    sget-object v5, Lcom/example/myphone/MainActivity;->objPhone:Lcom/example/myphone/CPhone;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteException; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v5, :cond_0

    .line 228
    :try_start_1
    invoke-virtual/range {v29 .. v29}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    const-string v6, "gbk"

    invoke-virtual {v5, v6}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v9

    .line 229
    .local v9, "bArry":[B
    sget-object v5, Lcom/example/myphone/MainActivity;->objPhone:Lcom/example/myphone/CPhone;

    .line 230
    array-length v6, v9

    .line 229
    invoke-virtual {v5, v9, v6}, Lcom/example/myphone/CPhone;->SendAllSmsMsg([BI)V
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Landroid/database/sqlite/SQLiteException; {:try_start_1 .. :try_end_1} :catch_1

    goto/16 :goto_0

    .line 231
    .end local v9    # "bArry":[B
    :catch_0
    move-exception v15

    .line 232
    .local v15, "e":Ljava/io/UnsupportedEncodingException;
    :try_start_2
    invoke-virtual {v15}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V
    :try_end_2
    .catch Landroid/database/sqlite/SQLiteException; {:try_start_2 .. :try_end_2} :catch_1

    goto/16 :goto_0

    .line 237
    .end local v2    # "cr":Landroid/content/ContentResolver;
    .end local v3    # "uri":Landroid/net/Uri;
    .end local v4    # "projection":[Ljava/lang/String;
    .end local v10    # "cur":Landroid/database/Cursor;
    .end local v13    # "dateColumn":I
    .end local v15    # "e":Ljava/io/UnsupportedEncodingException;
    .end local v17    # "nCount":I
    .end local v18    # "lCurSmsDate":J
    .end local v20    # "lMaxDate":J
    .end local v24    # "nameColumn":I
    .end local v26    # "phoneNumberColumn":I
    .end local v27    # "protocolColumn":I
    .end local v31    # "smsbodyColumn":I
    .end local v32    # "typeColumn":I
    :catch_1
    move-exception v16

    .line 239
    .local v16, "ex":Landroid/database/sqlite/SQLiteException;
    const-string v5, "SQLiteException in getSmsInPhone"

    invoke-virtual/range {v16 .. v16}, Landroid/database/sqlite/SQLiteException;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 185
    .end local v16    # "ex":Landroid/database/sqlite/SQLiteException;
    .restart local v2    # "cr":Landroid/content/ContentResolver;
    .restart local v3    # "uri":Landroid/net/Uri;
    .restart local v4    # "projection":[Ljava/lang/String;
    .restart local v10    # "cur":Landroid/database/Cursor;
    .restart local v13    # "dateColumn":I
    .restart local v17    # "nCount":I
    .restart local v18    # "lCurSmsDate":J
    .restart local v20    # "lMaxDate":J
    .restart local v24    # "nameColumn":I
    .restart local v26    # "phoneNumberColumn":I
    .restart local v27    # "protocolColumn":I
    .restart local v31    # "smsbodyColumn":I
    .restart local v32    # "typeColumn":I
    :cond_3
    add-int/lit8 v17, v17, 0x1

    .line 186
    :try_start_3
    move/from16 v0, v24

    invoke-interface {v10, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v23

    .line 187
    .local v23, "name":Ljava/lang/String;
    move/from16 v0, v26

    invoke-interface {v10, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v25

    .line 188
    .local v25, "phoneNumber":Ljava/lang/String;
    move/from16 v0, v31

    invoke-interface {v10, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v30

    .line 192
    .local v30, "smsbody":Ljava/lang/String;
    new-instance v14, Ljava/text/SimpleDateFormat;

    .line 193
    const-string v5, "yyyy-MM-dd hh:mm:ss"

    .line 192
    invoke-direct {v14, v5}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    .line 194
    .local v14, "dateFormat":Ljava/text/SimpleDateFormat;
    new-instance v11, Ljava/sql/Date;

    .line 195
    invoke-interface {v10, v13}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v5

    .line 194
    invoke-static {v5}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v6

    invoke-direct {v11, v6, v7}, Ljava/sql/Date;-><init>(J)V

    .line 196
    .local v11, "d":Ljava/sql/Date;
    invoke-virtual {v14, v11}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v12

    .line 197
    .local v12, "date":Ljava/lang/String;
    move/from16 v0, v32

    invoke-interface {v10, v0}, Landroid/database/Cursor;->getInt(I)I

    move-result v33

    .line 198
    .local v33, "typeId":I
    move/from16 v0, v27

    invoke-interface {v10, v0}, Landroid/database/Cursor;->getInt(I)I

    move-result v22

    .line 200
    .local v22, "nProtocol":I
    if-nez v23, :cond_4

    .line 202
    move-object/from16 v0, p0

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Lcom/example/myphone/PhoneInfo;->QueryNameFromNumber(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v23

    .line 204
    :cond_4
    if-nez v25, :cond_6

    .line 205
    const-string v25, "null"

    .line 208
    :cond_5
    :goto_2
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-static/range {v23 .. v23}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v6, "+"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v28

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 209
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-static/range {v25 .. v25}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v6, "+"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v28

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 210
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-static/range {v30 .. v30}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v6, "+"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v28

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 211
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-static {v12}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v6, "+"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v28

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 212
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-static/range {v33 .. v33}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v6, "+"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v28

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 213
    move-object/from16 v0, v28

    move/from16 v1, v22

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 214
    invoke-interface {v10}, Landroid/database/Cursor;->isLast()Z

    move-result v5

    if-nez v5, :cond_2

    .line 215
    const-string v5, "|"

    move-object/from16 v0, v28

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto/16 :goto_1

    .line 206
    :cond_6
    const-string v5, "+86"

    move-object/from16 v0, v25

    invoke-virtual {v0, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_5

    .line 207
    const/4 v5, 0x3

    move-object/from16 v0, v25

    invoke-virtual {v0, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    :try_end_3
    .catch Landroid/database/sqlite/SQLiteException; {:try_start_3 .. :try_end_3} :catch_1

    move-result-object v25

    goto/16 :goto_2
.end method

.method public GetHostIp()Ljava/lang/String;
    .locals 5

    .prologue
    .line 247
    :try_start_0
    invoke-static {}, Ljava/net/NetworkInterface;->getNetworkInterfaces()Ljava/util/Enumeration;

    move-result-object v0

    .local v0, "en":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :cond_0
    invoke-interface {v0}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v4

    if-nez v4, :cond_1

    .line 261
    .end local v0    # "en":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :goto_0
    const/4 v4, 0x0

    :goto_1
    return-object v4

    .line 248
    .restart local v0    # "en":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :cond_1
    invoke-interface {v0}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/net/NetworkInterface;

    .line 249
    .local v2, "intf":Ljava/net/NetworkInterface;
    invoke-virtual {v2}, Ljava/net/NetworkInterface;->getInetAddresses()Ljava/util/Enumeration;

    move-result-object v3

    .line 250
    .local v3, "ipAddr":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/InetAddress;>;"
    :cond_2
    invoke-interface {v3}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 251
    invoke-interface {v3}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/net/InetAddress;

    .line 252
    .local v1, "inetAddress":Ljava/net/InetAddress;
    invoke-virtual {v1}, Ljava/net/InetAddress;->isLoopbackAddress()Z

    move-result v4

    if-nez v4, :cond_2

    .line 253
    invoke-virtual {v1}, Ljava/net/InetAddress;->isLinkLocalAddress()Z

    move-result v4

    if-nez v4, :cond_2

    .line 254
    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;
    :try_end_0
    .catch Ljava/net/SocketException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v4

    goto :goto_1

    .line 259
    .end local v0    # "en":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    .end local v1    # "inetAddress":Ljava/net/InetAddress;
    .end local v2    # "intf":Ljava/net/NetworkInterface;
    .end local v3    # "ipAddr":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/InetAddress;>;"
    :catch_0
    move-exception v4

    goto :goto_0

    .line 258
    :catch_1
    move-exception v4

    goto :goto_0
.end method

.method public QueryContactsAndSend()V
    .locals 13

    .prologue
    .line 79
    const/4 v7, 0x0

    .line 83
    .local v7, "cursor":Landroid/database/Cursor;
    :try_start_0
    const-string v0, "MyPhone"

    const-string v1, "PhoneInfo::QueryContactsAndSend"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 85
    iget-object v0, p0, Lcom/example/myphone/PhoneInfo;->cxt:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 86
    sget-object v1, Landroid/provider/ContactsContract$CommonDataKinds$Phone;->CONTENT_URI:Landroid/net/Uri;

    .line 87
    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    .line 85
    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v7

    .line 88
    invoke-interface {v7}, Landroid/database/Cursor;->getCount()I

    move-result v10

    .line 89
    .local v10, "nContactCount":I
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    .line 90
    .local v12, "sb":Ljava/lang/StringBuilder;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {v10}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "$"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v12, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 91
    :cond_0
    :goto_0
    invoke-interface {v7}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-nez v0, :cond_2

    .line 109
    const-string v0, "MyPhone"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u5373\u5c06\u53d1\u9001\uff1a"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 110
    sget-object v0, Lcom/example/myphone/MainActivity;->objPhone:Lcom/example/myphone/CPhone;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_1

    .line 114
    :try_start_1
    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "gbk"

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v6

    .line 115
    .local v6, "bArry":[B
    sget-object v0, Lcom/example/myphone/MainActivity;->objPhone:Lcom/example/myphone/CPhone;

    .line 116
    array-length v1, v6

    .line 115
    invoke-virtual {v0, v6, v1}, Lcom/example/myphone/CPhone;->SendContacts([BI)V
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 125
    .end local v6    # "bArry":[B
    .end local v10    # "nContactCount":I
    .end local v12    # "sb":Ljava/lang/StringBuilder;
    :cond_1
    :goto_1
    return-void

    .line 96
    .restart local v10    # "nContactCount":I
    .restart local v12    # "sb":Ljava/lang/StringBuilder;
    :cond_2
    :try_start_2
    const-string v0, "display_name"

    .line 95
    invoke-interface {v7, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    .line 94
    invoke-interface {v7, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v8

    .line 101
    .local v8, "displayName":Ljava/lang/String;
    const-string v0, "data1"

    .line 100
    invoke-interface {v7, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    .line 99
    invoke-interface {v7, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v11

    .line 102
    .local v11, "number":Ljava/lang/String;
    const-string v0, " |-"

    const-string v1, ""

    invoke-virtual {v11, v0, v1}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 103
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "+"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v12, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 104
    invoke-interface {v7}, Landroid/database/Cursor;->isLast()Z

    move-result v0

    if-nez v0, :cond_0

    .line 105
    const-string v0, "|"

    invoke-virtual {v12, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 121
    .end local v8    # "displayName":Ljava/lang/String;
    .end local v10    # "nContactCount":I
    .end local v11    # "number":Ljava/lang/String;
    .end local v12    # "sb":Ljava/lang/StringBuilder;
    :catch_0
    move-exception v0

    goto :goto_1

    .line 117
    .restart local v10    # "nContactCount":I
    .restart local v12    # "sb":Ljava/lang/StringBuilder;
    :catch_1
    move-exception v9

    .line 118
    .local v9, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v9}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_1
.end method

.method public QueryNameFromNumber(Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p1, "num"    # Ljava/lang/String;

    .prologue
    .line 48
    const/4 v6, 0x0

    .line 52
    .local v6, "cursor":Landroid/database/Cursor;
    :try_start_0
    const-string v0, "MyPhone"

    const-string v1, "PhoneInfo::QueryNameFromNumber"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 53
    const/4 v0, 0x2

    new-array v2, v0, [Ljava/lang/String;

    const/4 v0, 0x0

    const-string v1, "data1"

    aput-object v1, v2, v0

    const/4 v0, 0x1

    const-string v1, "display_name"

    aput-object v1, v2, v0

    .line 54
    .local v2, "projection":[Ljava/lang/String;
    const/4 v0, 0x1

    new-array v4, v0, [Ljava/lang/String;

    const/4 v0, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v4, v0

    .line 56
    .local v4, "selectionArgs":[Ljava/lang/String;
    iget-object v0, p0, Lcom/example/myphone/PhoneInfo;->cxt:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 57
    sget-object v1, Landroid/provider/ContactsContract$CommonDataKinds$Phone;->CONTENT_URI:Landroid/net/Uri;

    .line 58
    const-string v3, " data1 = ?"

    const/4 v5, 0x0

    .line 56
    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    .line 59
    invoke-interface {v6}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 63
    const-string v0, "display_name"

    invoke-interface {v6, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    .line 62
    invoke-interface {v6, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v7

    .line 71
    .end local v2    # "projection":[Ljava/lang/String;
    .end local v4    # "selectionArgs":[Ljava/lang/String;
    :goto_0
    return-object v7

    .line 67
    :catch_0
    move-exception v0

    .line 71
    :cond_0
    const-string v7, "null"

    goto :goto_0
.end method

.method public getIMEI()Ljava/lang/String;
    .locals 2

    .prologue
    .line 298
    const/4 v0, 0x0

    .line 299
    .local v0, "IMEI":Ljava/lang/String;
    iget-object v1, p0, Lcom/example/myphone/PhoneInfo;->telephonyManager:Landroid/telephony/TelephonyManager;

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;

    move-result-object v0

    .line 300
    return-object v0
.end method

.method public getModel()Ljava/lang/String;
    .locals 2

    .prologue
    .line 269
    const-string v0, "N/A"

    .line 270
    .local v0, "Model":Ljava/lang/String;
    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v0

    .line 271
    return-object v0
.end method

.method public getNativePhoneNumber()Ljava/lang/String;
    .locals 2

    .prologue
    .line 289
    const-string v0, "N/A"

    .line 290
    .local v0, "NativePhoneNumber":Ljava/lang/String;
    iget-object v1, p0, Lcom/example/myphone/PhoneInfo;->telephonyManager:Landroid/telephony/TelephonyManager;

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v0

    .line 291
    return-object v0
.end method

.method public getPhoneInfo()Ljava/lang/String;
    .locals 4

    .prologue
    .line 326
    iget-object v2, p0, Lcom/example/myphone/PhoneInfo;->cxt:Landroid/content/Context;

    const-string v3, "phone"

    invoke-virtual {v2, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/telephony/TelephonyManager;

    .line 327
    .local v1, "tm":Landroid/telephony/TelephonyManager;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 329
    .local v0, "sb":Ljava/lang/StringBuilder;
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nDeviceId(IMEI) = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 330
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nDeviceSoftwareVersion = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getDeviceSoftwareVersion()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 331
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nLine1Number = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 332
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nNetworkCountryIso = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getNetworkCountryIso()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 333
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nNetworkOperator = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getNetworkOperator()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 334
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nNetworkOperatorName = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getNetworkOperatorName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 335
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nNetworkType = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getNetworkType()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 336
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nPhoneType = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 337
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nSimCountryIso = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getSimCountryIso()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 338
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nSimOperator = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getSimOperator()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 339
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nSimOperatorName = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getSimOperatorName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 340
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nSimSerialNumber = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getSimSerialNumber()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 341
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nSimState = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getSimState()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 342
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nSubscriberId(IMSI) = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getSubscriberId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 343
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "\nVoiceMailNumber = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getVoiceMailNumber()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 344
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method public getProvidersName()Ljava/lang/String;
    .locals 4

    .prologue
    .line 307
    const-string v0, "N/A"

    .line 309
    .local v0, "ProvidersName":Ljava/lang/String;
    :try_start_0
    iget-object v2, p0, Lcom/example/myphone/PhoneInfo;->telephonyManager:Landroid/telephony/TelephonyManager;

    invoke-virtual {v2}, Landroid/telephony/TelephonyManager;->getSubscriberId()Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/example/myphone/PhoneInfo;->IMSI:Ljava/lang/String;

    .line 311
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    iget-object v3, p0, Lcom/example/myphone/PhoneInfo;->IMSI:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 312
    iget-object v2, p0, Lcom/example/myphone/PhoneInfo;->IMSI:Ljava/lang/String;

    const-string v3, "46000"

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/example/myphone/PhoneInfo;->IMSI:Ljava/lang/String;

    const-string v3, "46002"

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 313
    :cond_0
    const-string v0, "\u4e2d\u56fd\u79fb\u52a8"

    .line 322
    :cond_1
    :goto_0
    return-object v0

    .line 314
    :cond_2
    iget-object v2, p0, Lcom/example/myphone/PhoneInfo;->IMSI:Ljava/lang/String;

    const-string v3, "46001"

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 315
    const-string v0, "\u4e2d\u56fd\u8054\u901a"

    .line 316
    goto :goto_0

    :cond_3
    iget-object v2, p0, Lcom/example/myphone/PhoneInfo;->IMSI:Ljava/lang/String;

    const-string v3, "46003"

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 317
    const-string v0, "\u4e2d\u56fd\u7535\u4fe1"
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 319
    :catch_0
    move-exception v1

    .line 320
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public getVersion()Ljava/lang/String;
    .locals 2

    .prologue
    .line 279
    const/4 v0, 0x0

    .line 280
    .local v0, "Version":Ljava/lang/String;
    sget-object v1, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v0

    .line 282
    return-object v0
.end method
