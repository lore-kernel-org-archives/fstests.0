Return-Path: <SRS0=Zf7U=C6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746B6C43465
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 17:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0B5206BE
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 17:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Id7LlM1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgIURKr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Sep 2020 13:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727269AbgIURKr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Sep 2020 13:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600708246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ybFOyiv6noKbX7nNOc26Rn/wLRJbu1BRraDY2NEEyM=;
        b=Id7LlM1iiSOdpuaFxqpvUkiSUDVdIOkJzqYh3OIkeHN22csgYrQ04eExN9Xq2wa5gsUFEB
        zgHYgkQc7tFQceUmM20c6NEON65bmLtiP543ZjOIRv8qwUCb0hoXgkSp13bWTPRJ08gmgP
        9TEJvccl0L0XNWqZCU8qZC9++I4rn7g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-zucZnkG-M-Ce19tltqGdOg-1; Mon, 21 Sep 2020 13:10:44 -0400
X-MC-Unique: zucZnkG-M-Ce19tltqGdOg-1
Received: by mail-wm1-f70.google.com with SMTP id m19so84884wmg.6
        for <fstests@vger.kernel.org>; Mon, 21 Sep 2020 10:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ybFOyiv6noKbX7nNOc26Rn/wLRJbu1BRraDY2NEEyM=;
        b=RPpEN6bdJaVXJqmfQI9KISDYla500md+ZPv8gL55k4mZsYhiUTw7FakT8ker36BXhk
         hjuETFlTgP6ICYV3BaMhN3GjNik01vZsqrmQ3ye5zJZH42Sj1iG6myIJ909jcxAMtMei
         Ivl5s8xHUZRvoZmHFEFq5EgeKr5UUYl582BfVSFVqd/MOa3OkBF5dCcjbfUKJywcRYqC
         Q0jzGRkWxbl5G8eTUbCAp6sHzq9uAwod+tDceoFrTr4rAoEx/mQ6djLePMgRdKvEM+uA
         8ZdI8F/3cvb70k9hDu9FUGED1H3SjE+TqSGghjuRtpacW7JFRWl5R4JJfI67KDvVV/d/
         JI2Q==
X-Gm-Message-State: AOAM533V4jz5HZpjdsVUdZmS5RBZEanQel+rkabkpHMLj7+YCe4KPU85
        KkWpb0zuwasYmlqQDuLCHLfPYls0uXDpkSth3VLu0o+TRAlc4H00oYch7SCq6YOClIQc8bPGTiG
        1aQOSkycJfXX79i7nCg==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr734524wrn.209.1600708243161;
        Mon, 21 Sep 2020 10:10:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCZRh36PvPzqt5HcS7u8gD+ncu2oakmy63J6JN8MFRHImPsxkktTQjyIbnPATpcDlAs529Hw==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr734508wrn.209.1600708242957;
        Mon, 21 Sep 2020 10:10:42 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id q12sm20792700wrs.48.2020.09.21.10.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 10:10:42 -0700 (PDT)
Subject: Re: [PATCH v3] xfs: Add test for too-small device with stripe
 geometry
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests@vger.kernel.org
References: <20200921085511.98739-1-preichl@redhat.com>
 <20200921164309.GO7954@magnolia>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <c6be5eba-9bf7-a9bc-f81b-63d45957a130@redhat.com>
Date:   Mon, 21 Sep 2020 19:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921164309.GO7954@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 9/21/20 6:43 PM, Darrick J. Wong wrote:
> On Mon, Sep 21, 2020 at 10:55:11AM +0200, Pavel Reichl wrote:
>> Verify hat an attempt to create a too-small device with stripe geometry,
>> is handled gracefully instead of hitting an assert in align_ag_geometry()
>>
>> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> 
> Looks ok (afaict the only change was removing _supported_os?)
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 

Hi,

sorry I should have added cover-letter,
Changes (mostly requested by Eryu):

* removed _supported_os
* fixed missing copyright
* s/kernel/xfsprogs in 'the problem fixed in kernel with commit'
* -localfile=$TEST_DIR/260.$$ 
  +localfile=$TEST_DIR/$seq.$$
* replaced 'truncate...' with 'XFS_IO_PROG -f -c "truncate...'

Bye.

