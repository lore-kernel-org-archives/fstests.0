Return-Path: <SRS0=clGf=3F=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4409EC33CB1
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jan 2020 16:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D32A207FF
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jan 2020 16:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="D/rT6eML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgAPQFN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:05:13 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46613 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgAPQFN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Jan 2020 11:05:13 -0500
Received: by mail-qt1-f193.google.com with SMTP id e25so7935802qtr.13
        for <fstests@vger.kernel.org>; Thu, 16 Jan 2020 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gc3py9UBWiNK/cKXsjedMrUzYeD4Eg0Xm+IR66/FEkA=;
        b=D/rT6eML6+9pi7wjybuOzWfsuwBxocZnoKDBjAqLnWLwqSOHOZA6odhZod60152z3/
         b9+kypm9Fly6dfTQ8NS2hiRlpo8NIh+e/0ubTPM1vTYZ9DptgsWahk18MRt987tDkNo6
         OF1NkqUwk9yUyUo50y/TzeVlPHUNJC/NScdHiUrbmOFHw42Xh+Ot/Ny5tYqwBXn6gALE
         zbs8gnPp6Q3aKFDDUY5LVR1SaN/ktWXfZH4r0WmkcluzHbgD4Ci/eOqLR7p+XEEzh6aT
         i65kDnXkA0FPPb47B1z6MZgjRaffYkkNUbnS18cPGX1H+7C93+ocwteTZgUEuKp639Bg
         VY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gc3py9UBWiNK/cKXsjedMrUzYeD4Eg0Xm+IR66/FEkA=;
        b=UTI+aTU9fLZFmLcVFHC/ExNQTxwfRjN/A+opE/WYds8PL553mnd6w64D98zyNlEGpa
         tsXzlc9ssTj+4diMApigxp66fqy7BgQByB0KT4gwm2r5/aqVldnvJDuKbLxeC0HsqgGb
         65KWNi2GDjRlH9ti08LHsQbujxO9zb6dh1lZLWlQ5PPiboN4hBb9O4cdNnpZNQYX6eSS
         34gjwhv7FE0Qj7chrEVYLe0Oq0R2T5SvJPmMnT/2Tqj3aX1y2oqq17aArkkxkf2tpbq6
         hPoakyZWOQPfoEhQx+tXWXGR/C/K5amME1yqtRFIHbmzKvjCzKXboZ0TW49quQ2stCXH
         sN1Q==
X-Gm-Message-State: APjAAAVfPzSEvb1PoayK+3Xkfkxmnz0riPnfuny34tc2ZBCRYRV9cGpc
        ZFkVPdJsO5GQpP5unQ3xXIWZ9Q==
X-Google-Smtp-Source: APXvYqwmtdqn1U86Aqsdnjfmg46sFO7c4aexk+J9IbLXz260G7Va5uRNi0hM3XrvkUedl+zirX/WMw==
X-Received: by 2002:ac8:342c:: with SMTP id u41mr3148055qtb.86.1579190712445;
        Thu, 16 Jan 2020 08:05:12 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6813])
        by smtp.gmail.com with ESMTPSA id q5sm10153726qkf.14.2020.01.16.08.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:05:11 -0800 (PST)
Subject: Re: [PATCH] generic/527: add additional test including a file with a
 hardlink
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200115132216.24041-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <785ebd3c-89cb-0079-782c-9fd1e07116fa@toxicpanda.com>
Date:   Thu, 16 Jan 2020 11:05:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200115132216.24041-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 1/15/20 8:22 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Add a similar test to the existing one but with a file that has a
> hardlink as well. This is motivated by a bug found in btrfs where
> a fsync on a file that has the old name of another file results
> in the logging code to hit an infinite loop. The patch that fixes
> the bug in btrfs has the following subject:
> 
>    "Btrfs: fix infinite loop during fsync after rename operations"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

What's our policy on adding a new variant to an existing test?  I thought we 
preferred to create a new test for these sort of things?  If not then you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

I have no strong opinions either way, I just know it's come up in the past.  Thanks,

Josef
