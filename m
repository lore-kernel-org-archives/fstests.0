Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB9EC433DB
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Mar 2021 21:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B7264F04
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Mar 2021 21:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCRVJh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Mar 2021 17:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24136 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231685AbhCRVJV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Mar 2021 17:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616101760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SJ2WV5u1mT60qsbmUsiNm2jm3MaX9k+rHuoR6bD9rGc=;
        b=aWkireOSH308D9qW8AjJwAGYyLLvQnUpdqZL8ySt848loY8nCe0Na6m7kJSoR5w5wsY9kC
        Cpbptr0OriX86y04cDguOSVnhHSCJIGu2JX3hL2oFfz20hL4fuHRmKja5xgDr4JAwjkhrV
        NbxUuT3r+hVvWtOVjPILn+NmV0ZLUSA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-ngstHoKpM8iMfhtfJnr7TQ-1; Thu, 18 Mar 2021 17:09:18 -0400
X-MC-Unique: ngstHoKpM8iMfhtfJnr7TQ-1
Received: by mail-wr1-f71.google.com with SMTP id h5so20628763wrr.17
        for <fstests@vger.kernel.org>; Thu, 18 Mar 2021 14:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SJ2WV5u1mT60qsbmUsiNm2jm3MaX9k+rHuoR6bD9rGc=;
        b=Ftru2LHAe5yRn19UMmZscIsr1/VgK/GDLLbkDBPx9T+t/wAVix0m7HruI8WYs9DLOm
         fYH0uVuFVX8dp8SDjWozLoJPJ+6RyLAjVIcCjTXE27MCSf9e0Y5Mzx3pLvyzS+2pjMTW
         yCgxl/WtvSo/P156wnM/v6pTFzyKMG5tu9BcsTqzhYse1vpbeRauQctUIPokq4iGjy6o
         htdhuM/fkGNdJ4klef9VAe55q9ekD6gUvJInnGOSRpn7tubkz8W6PxZ6O2ybC54gvf4j
         mVq7nFL74lgX48J1iIFEyFr4xJL683fWgLz6enCSNgwIZjQ0XSDb8D4mUdoJDMPtKmD+
         nGsg==
X-Gm-Message-State: AOAM530dlR2C1OSm/tgjqXHZn6M3mDUcSSB4JwkQSzFhgq8bw9cRW+D9
        go0eezFpfZQSNboX5AmENqczi4BWjwBtmroH2K+fHdqHR1fBbnUnDRk9Y3GDl9A7WxenNhEg46e
        tTBYizKoI7iBK8S/kio/nriFCpWJqRVcIyvgSsVVJ+ogp+ZAcRLXy04XJRiiBZrKQBliq
X-Received: by 2002:adf:f083:: with SMTP id n3mr1160585wro.134.1616101757192;
        Thu, 18 Mar 2021 14:09:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIPcugQc5FkCOFu6iJcwgH4nEv4pDZg1N2ctAVAPodtQA6TkRxlYgHDdZqqOhDs9TN9kRH5Q==
X-Received: by 2002:adf:f083:: with SMTP id n3mr1160571wro.134.1616101757000;
        Thu, 18 Mar 2021 14:09:17 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id u2sm4782153wmm.5.2021.03.18.14.09.16
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 14:09:16 -0700 (PDT)
Subject: Re: [PATCH] xfs/528: Add test for printing deprec. mount options
To:     fstests@vger.kernel.org
References: <20210310210228.58788-1-preichl@redhat.com>
 <20210318064204.GA13946@localhost.localdomain>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <cc3c51a1-15f7-19fe-ae4b-183b63387617@redhat.com>
Date:   Thu, 18 Mar 2021 22:09:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318064204.GA13946@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +_require_check_dmesg
>> +_supported_fs xfs
>> +_require_scratch
> 
> Use _require_check_dmesg to make sure /dev/kmsg is writable.

Ugh...I think I do that 2 lines above, right?

> 
>> +
>> +log_tag()
>> +{
>> +	echo "fstests $seqnum [tag]" > /dev/kmsg
>> +}
>> +
>> +dmesg_since_test_tag()
>> +{
>> +	dmesg | tac | sed -ne "0,\#fstests $seqnum \[tag\]#p" | \
>> +		tac
>> +}
>> +
>> +check_dmesg_for_since_tag()
>> +{
>> +	dmesg_since_test_tag | egrep -q "$1"
>> +}
>> +
>> +echo "Silence is golden."
>> +
>> +
>> +# Skip old kernels that did not print the warning yet
>> +log_tag
>> +_scratch_mkfs > $seqres.full 2>&1
>> +_scratch_mount -o attr2
>> +umount $SCRATCH_MNT
> 
>    ^^ _scratch_unmount
> 
>> +check_dmesg_for_since_tag "XFS: attr2 mount option is deprecated" || \
>> +	_notrun "Deprecation warning are not printed at all."
>> +
>> +# Test mount with default options (attr2 and noikeep) and remount with
>> +# 2 groups of options
>> +# 1) the defaults (attr2, noikeep)
>> +# 2) non defaults (noattr2, ikeep)
>> +_scratch_mount
>> +for VAR in {attr2,noikeep}; do
>> +	log_tag
>> +	mount -o $VAR,remount $SCRATCH_MNT
>> +	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated." && \
>> +		echo "Should not be able to find deprecation warning for $VAR"
>> +done
>> +for VAR in {noattr2,ikeep}; do
>> +	log_tag
>> +	mount -o $VAR,remount $SCRATCH_MNT
>> +	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated" || \
>> +		echo "Could not find deprecation warning for $VAR"
>> +done
>> +umount $SCRATCH_MNT
> 
>    ^^ _scratch_unmount
> 
> Just for making sure, looks like You test if remount print "deprecation warning"
> properly. What about mount? Should mount has "proper deprecation warning" output?
> 
> Actually, you'd better to describe what's the "proper" behavior, what's not, or
> what issue are you trying to cover in a test case.


Recent patch: "c23c393eaab5d xfs: remove deprecated mount options", added warning about deprecated options being passed as mount options. These warnings are currently printed *both during mount and remount* of the FS.

However some users find the repetitive printing of warnings *during remount* as an inconvenience (https://bugzilla.kernel.org/show_bug.cgi?id=211605 - Re-mount XFS causes "attr2 mount option is deprecated" warning).

To address this a patch that stops printing the warning on *remount* (if the option has the same value as during the mount) was proposed https://lore.kernel.org/linux-xfs/20210224214323.394286-1-preichl@redhat.com/

Is it clear now?

Thanks for the comments.

