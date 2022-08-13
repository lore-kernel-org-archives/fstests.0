Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A20C19F2D
	for <linux-fstests@archiver.kernel.org>; Sat, 13 Aug 2022 09:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiHMJBD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 13 Aug 2022 05:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMJBC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 13 Aug 2022 05:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8281D5F4F
        for <fstests@vger.kernel.org>; Sat, 13 Aug 2022 02:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660381260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40Ac1XgWVNjwyYkKjGSbTgvoGqrCfe3UlGVGhjobyDI=;
        b=G3ymg5OGzdr2b/qqWcP5SYNBFEEtdVzm12hu4RINYSPzfpDAvdEJdh3rqrwo3OB7get4MB
        zlTpuMqN9SHKYSwrXkRWrF3oyyo+kpzQMDuAALg65nSnVRuMHNqeV2q+hf6/NUp8kcRpAb
        MuQBjOcONFv6xbH35XtGlbmiYmWxdBk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-30jPYaURNxCae62hEhheUg-1; Sat, 13 Aug 2022 05:00:59 -0400
X-MC-Unique: 30jPYaURNxCae62hEhheUg-1
Received: by mail-ed1-f71.google.com with SMTP id c14-20020a05640227ce00b0043e5df12e2cso1969643ede.15
        for <fstests@vger.kernel.org>; Sat, 13 Aug 2022 02:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=40Ac1XgWVNjwyYkKjGSbTgvoGqrCfe3UlGVGhjobyDI=;
        b=IDXW4Jn5V+weqP8OSZcXzXOL6gKkFI0+P+D54/eP+8U37bEN0XzdUMsmpAC/lmjbOw
         jCaAXjojy4fBz5BXK4BikeHQA71OR1vB9CrPcRQgd7TT74liKFbVPhubGP7n0mggyOwZ
         LrFlZQv9I0WREyRqFcxipRcRbz2I1MjlKexVvFkD0cPwCb7COG4hNA5uTUt5AItv07wr
         OGzOdbjFvmNDoT/4vV8JwavwtZMtTRElQYS7fM32jZOvh0Bi+zA2dsNBlu1kcGOCyI33
         L+4HavxfG8+13o94wx1AY6HJ50wB4q3g6g+TCNroCphAVzg/scnouUIEH3DVSB9aF8hX
         mY+g==
X-Gm-Message-State: ACgBeo1Xs1yhgpTLkAAiENjfAbBJA/xwr/CY2QDY/9A9wRCKwvMcO+iQ
        LEX9SYqaxpn2u6yb3dHwsxbpUjOoz9lZpsWqZpsLTUQt5FUB8gaR5JKUR8ZXCTMpbde7Reo1xOT
        /qq+tR5zsCoP3Trz2dA==
X-Received: by 2002:a17:907:a414:b0:731:6473:b38d with SMTP id sg20-20020a170907a41400b007316473b38dmr4998654ejc.662.1660381258025;
        Sat, 13 Aug 2022 02:00:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6m/3nJaDJw1w9O4PauormWMzYPes+GYGzODWr2OvtPvV2bxkFswzVSCsVk7VvEq1DxfsSnpw==
X-Received: by 2002:a17:907:a414:b0:731:6473:b38d with SMTP id sg20-20020a170907a41400b007316473b38dmr4998642ejc.662.1660381257748;
        Sat, 13 Aug 2022 02:00:57 -0700 (PDT)
Received: from [192.168.100.69] (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090627c800b00730ba005b39sm1680688ejc.132.2022.08.13.02.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 02:00:56 -0700 (PDT)
Message-ID: <292c6dd6-fcc7-f163-ca79-34e021beaa7d@redhat.com>
Date:   Sat, 13 Aug 2022 11:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] generic: test i_blocks for large files
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, sj1557.seo@samsung.com
References: <20220812145050.43966-1-preichl@redhat.com>
 <20220813054438.ghygw23t6phvuwos@zlang-mailbox>
From:   Pavel Reichl <preichl@redhat.com>
In-Reply-To: <20220813054438.ghygw23t6phvuwos@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 8/13/22 07:44, Zorro Lang wrote:
> On Fri, Aug 12, 2022 at 04:50:50PM +0200, Pavel Reichl wrote:
>> This is a regression test for an incorrect
>> computation of i_blocks for files larger than
>> 4 GiB. Bug was filed for exFAT.
>>
>> Signed-off-by: Pavel Reichl <preichl@redhat.com>
>> ---
>>   tests/generic/693-inodes-for-large-files     | 49 ++++++++++++++++++++
>>   tests/generic/693-inodes-for-large-files.out |  1 +
>>   2 files changed, 50 insertions(+)
>>   create mode 100755 tests/generic/693-inodes-for-large-files
>>   create mode 100644 tests/generic/693-inodes-for-large-files.out
>>
>> diff --git a/tests/generic/693-inodes-for-large-files b/tests/generic/693-inodes-for-large-files
> I think case *number* is enough.
0K, the 'new' script asked, so I provided:-)
>
>> new file mode 100755
>> index 00000000..797d6a21
>> --- /dev/null
>> +++ b/tests/generic/693-inodes-for-large-files
>> @@ -0,0 +1,49 @@
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
>> +_require_test
> If this test need 4G free space, I'm wondering if we need to make sure
> there's enough space in $TEST_DIR, as we do in _require_scratch_size.
OK, I'll look into it.
>
>> +
>> +junk_dir=$TEST_DIR/$seq
>> +junk_file=$junk_dir/junk
>> +mkdir -p $junk_dir
>> +
>> +$XFS_IO_PROG -f -c "truncate 4G" $junk_file
> It helps to allocate 4g real space on exfat, due to exfat doesn't
> support sparse file, but on other filesystems (e.g. xfs, ext4, btrfs)
> it will get a file which i_blocks=0.
OK, I know that and I think it's fine - I just need a test for 
consistency after remounting.
>
> As a generic test case, if you really want to allocate 4g real space,
> I think you have to real write data:
>
>    $XFS_IO_PROG -f -c "pwrite -W 0 4g" $junk_file
>
> If anyone knows any better idea, feel free to reply :)
>
>> +
>> +iblocks=`$XFS_IO_PROG -c "stat" $junk_file | grep 'stat.blocks'`
> stat -c %b $junk_file ??
>
>> +test -z "$iblocks" && echo 'Failed to parse the blocks'
>> +
>> +_test_cycle_mount
>> +
>> +iblocks_after_remount=`$XFS_IO_PROG -c "stat" $junk_file | grep 'stat.blocks'`
> stat -c %b $junk_file ??
>
>> +
>> +test -z "$iblocks_after_remount" && echo 'Failed to parse the blocks'
> When will we get an empty "$iblocks_after_remount" ?
It is just a check that both xfs_io and grep worked as expected.
>
>> +
>> +if [ "$iblocks" != "$iblocks_after_remount" ]; then
>> +	echo "Number of blocks needs to be same: $iblocks, $iblocks_after_remount"
>> +	status=1
> If you "exit" directly, the status is 1 by default. But I think you don't need
> to exit at here, due to above output will break golden image and fail this test.
OK, I'll fix that. Thanks!
>
>> +	exit
>> +fi
>> +
>> +status=0
>> +
>> +exit
>> diff --git a/tests/generic/693-inodes-for-large-files.out b/tests/generic/693-inodes-for-large-files.out
>> new file mode 100644
>> index 00000000..f39aa77c
>> --- /dev/null
>> +++ b/tests/generic/693-inodes-for-large-files.out
>> @@ -0,0 +1 @@
>> +QA output created by 693-inodes-for-large-files
> Silence is golden ??

Well I don't echo that in the script, but if that's custom I'll do it.


Thanks for the comments!

>
>> -- 
>> 2.37.1
>>

