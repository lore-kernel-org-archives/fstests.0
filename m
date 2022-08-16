Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E122C25B0E
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Aug 2022 16:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiHPQK1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 Aug 2022 12:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbiHPQKG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Aug 2022 12:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36DE50720
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2022 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660666107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fDo6IFh0vBZ7RjsUBd1vmneAV1xjbv1EJ5UjA85t2tw=;
        b=H+lZQtKQ6xNO72jrkQQF5jakehqzYMei1F8n9ca938mIH8GX7UeOmoefOytDOyrtlpeZ9Q
        MaLHeVIPfeOeYObioVk8Vxbs4heWHe1Ch6bx1mBsveDXVm6hTmiS5OlxzMkUFsmKZ0wFyy
        RQJjejJJioqphzNDBbh7bPqXGjsvcnE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-219-ly0IhfajNk2jpe72i4J5tg-1; Tue, 16 Aug 2022 12:08:24 -0400
X-MC-Unique: ly0IhfajNk2jpe72i4J5tg-1
Received: by mail-wm1-f70.google.com with SMTP id c189-20020a1c35c6000000b003a4bfb16d86so5101392wma.3
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2022 09:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fDo6IFh0vBZ7RjsUBd1vmneAV1xjbv1EJ5UjA85t2tw=;
        b=yXYu3uh4U6H+w+RnlT9pdS2HMTrCP5VEPWRrqJGZS+qq2Gt6cNnE5QFNRPSZSmwhpY
         Xxe0WoxEY5pN6q89buBakyIwL+/8f1NKUIQ0MvYRaQpi3w4MaRgQJPHLJTN9hvCJo/xn
         NFtWd469hnp739moySfwfUASLGeb7m/pIC43yEr5lgETOESpP5LJQwM+0s1L6yNO6jJf
         DipCPupIMr3T8K7KRYr/Er+q81z9/8piskPlr+w+roLo1SB3VaiKJtA0gCx7wfyXMSD+
         UAv7/F6uU5wlOdo9yRMm1kpdW8daomhjzTZLJwQB9o3q0JCKaA85cq2EB4RRWyZ9FoIb
         4DRA==
X-Gm-Message-State: ACgBeo0N5KGI7HOwRjYA91z4EzxQCxRBHBC1bez50LxxWtOswl2KsPB7
        fJO/UToSjXHlA/ZLGzgJl2xwP7zGZZQxaO8W70V0ll9CxMApjC/tqOAlp17rHlrBef+bLzV28sV
        dCoPv2DSnSsv0/uB9/w==
X-Received: by 2002:a05:6000:1acb:b0:223:5de3:f8bf with SMTP id i11-20020a0560001acb00b002235de3f8bfmr11955290wry.691.1660666101693;
        Tue, 16 Aug 2022 09:08:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR48C9d3SZ/ZhE7wtQixo0piZ3yD8LQJDqt7En54TZe5PU48/EkmSGMPta3rvQEKzibat14Z9Q==
X-Received: by 2002:a05:6000:1acb:b0:223:5de3:f8bf with SMTP id i11-20020a0560001acb00b002235de3f8bfmr11955274wry.691.1660666101408;
        Tue, 16 Aug 2022 09:08:21 -0700 (PDT)
Received: from [192.168.100.69] (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id az3-20020adfe183000000b002207a0b93b4sm11057527wrb.49.2022.08.16.09.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 09:08:20 -0700 (PDT)
Message-ID: <72131fe1-a48f-1ab5-a9c3-561e8b4af1ee@redhat.com>
Date:   Tue, 16 Aug 2022 18:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] generic: test i_blocks for large files
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
References: <20220813054438.ghygw23t6phvuwos@zlang-mailbox>
 <20220816104536.273937-1-preichl@redhat.com> <Yvu+i1sxTD/KcVjL@magnolia>
From:   Pavel Reichl <preichl@redhat.com>
In-Reply-To: <Yvu+i1sxTD/KcVjL@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 8/16/22 17:58, Darrick J. Wong wrote:
> On Tue, Aug 16, 2022 at 12:45:36PM +0200, Pavel Reichl wrote:
>> This is a regression test for an incorrect
>> computation of i_blocks for files larger than
>> 4 GiB. Bug was filed for exFAT.
>>
>> Signed-off-by: Pavel Reichl <preichl@redhat.com>
>> ---
>>   common/rc             | 10 ++++++++++
>>   tests/generic/693     | 46 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/693.out |  2 ++
>>   3 files changed, 58 insertions(+)
>>   create mode 100755 tests/generic/693
>>   create mode 100644 tests/generic/693.out
>>
>> diff --git a/common/rc b/common/rc
>> index 197c9415..06cbdee5 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1980,6 +1980,16 @@ _require_test()
>>       touch ${RESULT_DIR}/require_test
>>   }
>>   
>> +# require a test dev of a minimum size (in kb)
>> +_require_test_size()
>> +{
>> +	[ $# -eq 1 ] || _fail "_require_test_size: expected size param"
>> +
>> +	_require_test
>> +	local devsize=`_get_device_size $TEST_DEV`
>> +	[ $devsize -lt $1 ] && _notrun "test dev too small"
>> +}
>> +
>>   _has_logdev()
>>   {
>>   	local ret=0
>> diff --git a/tests/generic/693 b/tests/generic/693
>> new file mode 100755
>> index 00000000..a6d1abff
>> --- /dev/null
>> +++ b/tests/generic/693
>> @@ -0,0 +1,46 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
>> +#
>> +# FS QA Test 693
>> +#
>> +# Verify that i_blocks for files larger than 4 GiB have correct
>> +# values.
>> +#
>> +# This test verifies the problem fixed in kernel with commit
>> +# 0c336d6e33f4 exfat: fix incorrect loading of i_blocks for large files
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto
>> +
>> +# Override the default cleanup function.
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -r -f $tmp.* $junk_dir
>> +}
>> +
>> +_supported_fs generic
>> +_require_test_size $((4 * 1024 * 1024)) #kB
> What does this new helper do that "_require_fs_space $TEST_DIR 4194304"
> wouldn't solve?

Hello,

nothing  - I was not aware of that. I'll change it to use 
'_require_fs_space'

Thanks!

> --D
>
>> +
>> +echo "Silence is golden"
>> +
>> +junk_dir=$TEST_DIR/$seq
>> +junk_file=$junk_dir/junk
>> +mkdir -p $junk_dir
>> +
>> +$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
>> +
>> +iblocks=`stat -c '%b' $junk_file`
>> +
>> +_test_cycle_mount
>> +
>> +iblocks_after_remount=`stat -c '%b' $junk_file`
>> +
>> +if [ "$iblocks" != "$iblocks_after_remount" ]; then
>> +	echo "Number of blocks needs to be same: $iblocks, $iblocks_after_remount"
>> +fi
>> +
>> +status=0
>> +
>> +exit
>> diff --git a/tests/generic/693.out b/tests/generic/693.out
>> new file mode 100644
>> index 00000000..01884ea5
>> --- /dev/null
>> +++ b/tests/generic/693.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 693
>> +Silence is golden
>> -- 
>> 2.37.2
>>

