Return-Path: <SRS0=vNf0=5C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B66C10F29
	for <linux-fstests@archiver.kernel.org>; Tue, 17 Mar 2020 15:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF34C20754
	for <linux-fstests@archiver.kernel.org>; Tue, 17 Mar 2020 15:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cjr.nz header.i=@cjr.nz header.b="GTSHV5YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgCQPXr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:23:47 -0400
Received: from mx.cjr.nz ([51.158.111.142]:48868 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgCQPXr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 17 Mar 2020 11:23:47 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id C51AD80AB7;
        Tue, 17 Mar 2020 15:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1584458625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z6UeK1QUBsdAwTZ7ga6CXLjIeagaATUQlvXuNa2Snf0=;
        b=GTSHV5YQFHkfqMccLz+tAcDTWCvmcyRGeTbhrIXy50+UYRl0BeXVnAxS/GYlKKW3lMrkUq
        sJvnfXllrV0DV7wQMRz+/nVUP0gRUc6JRRFlu+NtbvGtvrIgNeYCJC7OC3PUSYxIOamSF/
        FkzEBRhLVtL++XtpK7kXUaYqwfW/2G5VjPgwkEtPa2MUJPM5RetVhHmRV99N2FQl64xJOd
        tRQ2jv15ys/6a+w7dQPTuzBwyhBpksAIFo6c6lMnp/SzOn1GVoYR4jGvMEZt8dggg1RMST
        4lM59JkF6/CW1YqMtP9+ef8VltINW2aE2k/Z8wK4tOwYxzs2SNKaeFkA6A+PVg==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Zorro Lang <zlang@redhat.com>, Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/310: slightly improve check for dmesg error
In-Reply-To: <20200317105544.GF14282@dhcp-12-102.nay.redhat.com>
References: <20200317015439.7406-1-pc@cjr.nz>
 <20200317105544.GF14282@dhcp-12-102.nay.redhat.com>
Date:   Tue, 17 Mar 2020 12:23:38 -0300
Message-ID: <85k13jron9.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Zorro Lang <zlang@redhat.com> writes:

> On Mon, Mar 16, 2020 at 10:54:39PM -0300, Paulo Alcantara (SUSE) wrote:
>> The 'grep -c "error"' check was causing false positive results for
>> cifs.ko when running it with 'echo 1 > /proc/fs/cifs/cifsFYI'.
>> 
>> That is, the test would fail when cifs.ko prints out a non-error
>> message like this:
>> 
>>   [ 2320.903987] fs/cifs/smb2maperror.c: Mapping SMB2 status code
>>   0x80000006 to POSIX err -61
>> 
>> Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
>> ---
>>  tests/generic/310 | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/tests/generic/310 b/tests/generic/310
>> index 1fcd517e4e6f..504f7c44c177 100755
>> --- a/tests/generic/310
>> +++ b/tests/generic/310
>> @@ -49,7 +49,7 @@ _require_command "$KILLALL_PROG" killall
>>  dmesg -c > /dev/null
>>  
>>  nr_bug=`dmesg | grep -c "kernel BUG"`
>> -nr_error=`dmesg | grep -c "error"`
>> +nr_error=`dmesg | grep -c "EXT[234]-fs error"`
>
> This's a generic test, which is not only for extN filesystem. If only for
> "fs/cifs/smb2maperror.c: Mapping SMB2 status ...", how about:
>    grep -wc "error"
> or
>    grep -c "\berror"
>
> or something better:)
>
> I think it still works for "EXT3-fs error (device loop1): ext3_readdir:
> bad entry in ....".

Both look good to me. Thanks for pointing it out!

Eryu,

Do you want me to resend or you can just apply one of above suggestions?
