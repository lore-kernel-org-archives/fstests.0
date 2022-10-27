Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422D3C38A2D
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Oct 2022 02:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiJ0CWa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Oct 2022 22:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiJ0CW3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Oct 2022 22:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B255EE09FE
        for <fstests@vger.kernel.org>; Wed, 26 Oct 2022 19:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666837346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MRQCDKG424hoLQ3Rdxsb+LxJnRBxQa3n1cGyU6McfhA=;
        b=GttY3idox+MmRhqpv6i7T7icXtIr1q5d58S4QxJw7IkaNhsisGTKcwyrXUUpNE/zcuGirO
        3dTmuO/DamoA2x+JpfnGsFrBiHRct3YbKLURDE6JJxUoOx0sL96FozKwmzHBXf3nWBg/0R
        xLaf8btw5MICpyRzZnuh9nomJBiq2yU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-457-SYS9Ffe_P9SsTsZXUQ5_Gw-1; Wed, 26 Oct 2022 22:22:23 -0400
X-MC-Unique: SYS9Ffe_P9SsTsZXUQ5_Gw-1
Received: by mail-pj1-f72.google.com with SMTP id p1-20020a17090a2c4100b00212733d7aaaso85835pjm.4
        for <fstests@vger.kernel.org>; Wed, 26 Oct 2022 19:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRQCDKG424hoLQ3Rdxsb+LxJnRBxQa3n1cGyU6McfhA=;
        b=vI9dEoiPlSWG61fV9a4RHsvZIxM3DfDq9kXZsaWT3dWCwoMvAUfGSNPzM+ec+bqLg+
         HuSQwzWF04Wcwm2uYuLDeFEuJWvNy5FPV8pFiJ0uHamXK0jPCYSf1q7g4zxyZxsx3ZBF
         0htUnZTJ8o/zvIjkxmZcmD/WTXhr1WIdJm8amO7iA0RkOcdsbyDfNbBb7WjEccs6DKfM
         xPVZDzxJwH8jQW6GSe6SqcE6tv2Zd8adw64dUp/hHfeAn9B9q/IOpxU4aC8Sgzwb3nW9
         9ILcFIugIxrSXFaVUjloCK8gcCGxQuqI14fpj7jamRoJGuYqrfOJNgK/6Y3GXCtuLJ7s
         KSWA==
X-Gm-Message-State: ACrzQf0nKWRTlthLI8jFe487mFfMmBJ08lXwY+9WbXEFNv8CLvRmpwRF
        n5GZcDfhR7+WXUuPj+iQFK1MJTa9iwrCKtOdFhBzUAXxFfmRtnYsiBivgFGRPghaVI499aiaa/3
        I7A1IfC/IMjyDqvabpQ==
X-Received: by 2002:a17:902:ab8f:b0:185:46d3:8c96 with SMTP id f15-20020a170902ab8f00b0018546d38c96mr49098127plr.136.1666837341864;
        Wed, 26 Oct 2022 19:22:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7VRZx5hSUV7wk7J0FKi6HlR2ODkTc9vbFPVMfuEepb7CT5kCIkMxcDY4t7fd9cbF2Lee22AA==
X-Received: by 2002:a17:902:ab8f:b0:185:46d3:8c96 with SMTP id f15-20020a170902ab8f00b0018546d38c96mr49098110plr.136.1666837341593;
        Wed, 26 Oct 2022 19:22:21 -0700 (PDT)
Received: from [10.72.12.170] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mv10-20020a17090b198a00b00212c27abcaesm1739516pjb.17.2022.10.26.19.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 19:22:20 -0700 (PDT)
Subject: Re: [PATCH 2/2] encrypt: add ceph support
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, david@fromorbit.com, djwong@kernel.org,
        lhenriques@suse.de, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        mchangir@redhat.com
References: <20221026070418.259351-1-xiubli@redhat.com>
 <20221026070418.259351-3-xiubli@redhat.com>
 <20221026141218.wg2h3ganvo2dx7hb@zlang-mailbox>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <9a8eaafa-fb5e-72dc-359e-edfb7cf5b954@redhat.com>
Date:   Thu, 27 Oct 2022 10:22:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221026141218.wg2h3ganvo2dx7hb@zlang-mailbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 26/10/2022 22:12, Zorro Lang wrote:
> On Wed, Oct 26, 2022 at 03:04:18PM +0800, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> For ceph we couldn't use the mkfs to check whether the encryption
>> is support or not, we need to mount it first and then check the
>> 'set_encpolicy', etc.
>>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   common/encrypt | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/common/encrypt b/common/encrypt
>> index fd620c41..e837c9de 100644
>> --- a/common/encrypt
>> +++ b/common/encrypt
>> @@ -153,6 +153,23 @@ _scratch_check_encrypted()
>>   		# erase the UBI volume; reformated automatically on next mount
>>   		$UBIUPDATEVOL_PROG ${SCRATCH_DEV} -t
>>   		;;
>> +	ceph)
>> +		# Try to mount the filesystem. We need to check whether the encryption
>> +		# is support or not via the ioctl cmd, such as 'set_encpolicy'.
>> +		if ! _try_scratch_mount &>>$seqres.full; then
>> +			_notrun "kernel is unaware of $FSTYP encryption feature," \
>> +				"or mkfs options are not compatible with encryption"
>> +		fi
>> +
>> +		mkdir $SCRATCH_MNT/tmpdir
>> +		if _set_encpolicy $SCRATCH_MNT/tmpdir 2>&1 >>$seqres.full | \
>> +			grep -Eq 'Inappropriate ioctl for device|Operation not supported'
>> +		then
>> +			_notrun "kernel does not support $FSTYP encryption"
>> +		fi
>> +		rmdir $SCRATCH_MNT/tmpdir
>> +		_scratch_unmount
> As I replied in patch 1/2, this function is a mkfs function, if ceph need a
> specific mkfs way, you can do it in this function, or you even can keep it
> empty
>
>    ceph)
> 	;;
>
> Or does a simple cleanup
>
>    ceph)
> 	_scratch_cleanup_files
> 	...
> 	;;
>
> I'm not familar with ceph, that depends on you. But the change in this patch is
> not "mkfs", it's a checking, checking if the current $SCRATCH_MNT supports
> encryption, you should do it in other function which does that checking job, not
> change a mkfs function to be a check function.

Sounds good. Let me check how to that.

Thanks Zorro again.

- Xiubo


> Thanks,
> Zorro
>
>> +		;;
>>   	*)
>>   		_notrun "No encryption support for $FSTYP"
>>   		;;
>> -- 
>> 2.31.1
>>

