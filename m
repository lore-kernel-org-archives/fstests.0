Return-Path: <SRS0=J6Lv=C3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B55C43463
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Sep 2020 06:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C75E20866
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Sep 2020 06:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc4ikskI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgIRGQZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 18 Sep 2020 02:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbgIRGQZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Sep 2020 02:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600409784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ErnScVvYtxX8knG5hGrGHq6aS1mBUN1TMPhsKghtqs=;
        b=Nc4ikskIJ6+fmZ1xXN0f8M4w0846zfzWb1+i+1B5M57kt8x1qnHGmMMZReJrmsZXEUfEvF
        MgO2v8ro58dhOlBN7Gh4noWlZ1Idh6uvbuTfBgEUn0LaxIOAH3/5YLpzXLhmzha5uTo1Ou
        a6fpmnDpTqEwRf1dSfvkaGxTaLXIsK0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-bbsLstrTMZ-WeIcxxhor_Q-1; Fri, 18 Sep 2020 02:16:22 -0400
X-MC-Unique: bbsLstrTMZ-WeIcxxhor_Q-1
Received: by mail-wm1-f72.google.com with SMTP id b14so1101911wmj.3
        for <fstests@vger.kernel.org>; Thu, 17 Sep 2020 23:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ErnScVvYtxX8knG5hGrGHq6aS1mBUN1TMPhsKghtqs=;
        b=f2mjlZxhTybCaikrXZRDJfQeyHEbfWJPu5oG0ze3+Mz7Xo8r0Ky2lriyJqOgHJXc5n
         S8xpN0yyv4Nc00m4ntx3KOhdJv2M+eHZwy2/Y7wpYkWlQ4PYb3gf8Yq1jaSbfKoNYfFQ
         qUfclq1G4DPG3qXZi2xK6PEob5PKlO+0/FpKLhK45raqXggAPIbtY05f7O+bh0oizQlO
         SMw4ldUwfZG0Duo7Sj3Y6Xd11ADmo0WSQNA5nhRI8OgbQboHaJCJlAhlbXa86mO7TWAq
         L4l8deRAyjwH690t1i9n+tDkVJVP10GSdXW2coHvVuk4+gmyYoKawzMKdHZQx3Wazna9
         j4sg==
X-Gm-Message-State: AOAM531R9v3SBRXgPqf/PDRDBraNOnqaWL3CtPSUWXOWBjepGSbL/HIW
        4GO+3+2rFatnx4qng3FGaifIfW6bUSEIo9IpPaft9oNQI/uf45jEjAszhijtpBr/pWp8H1LM1ox
        JAv41ac87ipJWHzn8RQ==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr39425046wrn.347.1600409780963;
        Thu, 17 Sep 2020 23:16:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGwh+Yk/XblsoU0vsZh8CwjMOo/S/c6m/gFI9s2Mhu6KAHH40vljTIb7H+eihNTgS+1pYvvQ==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr39425039wrn.347.1600409780778;
        Thu, 17 Sep 2020 23:16:20 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id x10sm3150980wmi.37.2020.09.17.23.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 23:16:20 -0700 (PDT)
Subject: Re: [PATCH] xfs: Add test for too-small device with stripe geometry
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests@vger.kernel.org
References: <20200917203639.104000-1-preichl@redhat.com>
 <20200917213509.GG7954@magnolia>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <c7e6c795-dba5-5c3a-5d90-1f750605e3a0@redhat.com>
Date:   Fri, 18 Sep 2020 08:16:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917213509.GG7954@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


>> +localfile="${SCRATCH_MNT}/testfile"
>> +truncate --size=10444800 $localfile
> 
> You could put this file under $TEST_DIR and skip a bunch of formatting
> and fsck runs of the scratch device.
> 
> --D
> 
OK, thanks. Next revision is on the list.

