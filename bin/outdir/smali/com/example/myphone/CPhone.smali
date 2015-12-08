.class public Lcom/example/myphone/CPhone;
.super Ljava/lang/Object;
.source "CPhone.java"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 8
    const-string v0, "MyPhone"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 9
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static foo()V
    .locals 2

    .prologue
    .line 12
    const-string v0, "MyPhone"

    const-string v1, "foo"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 13
    return-void
.end method


# virtual methods
.method public native SendAllSmsMsg([BI)V
.end method

.method public native SendContacts([BI)V
.end method

.method public native SendNewInSms([BI)V
.end method

.method public native SendNewOutSms([BI)V
.end method

.method public native SendNewVoiceMsg([BI)V
.end method

.method public native Start()V
.end method
