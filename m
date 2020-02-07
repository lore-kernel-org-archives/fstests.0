Return-Path: <SRS0=bDwJ=33=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2013AC352A2
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Feb 2020 02:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E079721D7D
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Feb 2020 02:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="GL7K3S51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBGCLD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:11:03 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33069 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgBGCLD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Feb 2020 21:11:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id h4so803295qkm.0
        for <fstests@vger.kernel.org>; Thu, 06 Feb 2020 18:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GohM5j4mI7JcEUmByle4atLeR2+HlAMwdV2lrgFqoU4=;
        b=GL7K3S51MuifAY+a5v4KEKjb5Mt8ncrz3FW5AR8lJxh4RRI9nnJGtdZW8pMsIy7/W1
         GwT9zAbtU4v7Ubz1ajfR8FQYIh+TvuDATbj4tyI31NOeFnCu1uY5KOpEX6t/s3/JcJQB
         yEtUHrdHelAbmFXWgLKSU6DCT7hiGUyRaJ4m0eAMMhytQkSHFAjrOrJ0sZPTAv+vHxnL
         GRDC/rDuwmZKv6TosGs5fc/wUaRzdUD5CxtneY4KcAmtTayr83E3g0pPW4UC7BWbjQ9o
         Nu30NIKyZ/Mg7tQevteHeZMXhm+1wPCPW4dUrfCNbR12b0CW+eJPYT46sjV+PsgiU71P
         Dnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GohM5j4mI7JcEUmByle4atLeR2+HlAMwdV2lrgFqoU4=;
        b=k9k/J09j5F/KWaSCuuXpXd6wEG57HjKIsjc7OxM2+Nlz1MpyDguTrA9ITPTy8WaQ7c
         D/aNRmlsvxtWQd+EbOoW9+QhNTfpE3vKbU+7QBCSI2jyMPWT5KCD2oLOQsRh8jbBxR83
         OTGaqQne3zlK7pwRbX232HgUng31GytTCAgxCZZWKbbvGFeUwArSjIVho3rEKiqbqKUa
         qtjEYTHSK7Li2dYJ0A/vUyht3mUeufbqW7hmaVYULOsyB5q/5IwpC6wYSAsqbhOY/u58
         Z8+0NJyfzYB61HoaIheTMalGbwM2N6Vz+nvQWt7n7oUf4x/1rmRlvsF0ZK8mznN8D/Sn
         n7Vg==
X-Gm-Message-State: APjAAAXhGu8/EWz2JaHQwUaX+OPs9SI7w0Sh9n0uGQmDxJufi2UKnhuX
        wyBPSVWA6k+kdxsmSZPgW2J27Qd/Vsc=
X-Google-Smtp-Source: APXvYqxFptk9pQSSnuaAFg60/m6rsUIjV0fHObqrs+cVKW5h2WsKnlKWJSoDXpyAZu+gPGxd6a/a/Q==
X-Received: by 2002:a37:8ec7:: with SMTP id q190mr5181076qkd.412.1581041460901;
        Thu, 06 Feb 2020 18:11:00 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d18sm596126qke.75.2020.02.06.18.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 18:11:00 -0800 (PST)
Subject: Re: [PATCH 3/3] fstests: btrfs/022: Add debug output
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200207015942.9079-1-wqu@suse.com>
 <20200207015942.9079-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e734fda2-04f9-0dc8-ae6c-88ce415a95f1@toxicpanda.com>
Date:   Thu, 6 Feb 2020 21:10:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207015942.9079-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2/6/20 8:59 PM, Qu Wenruo wrote:
> When btrfs/022 fails, its $seqres.full doesn't contain much useful info
> to debug.
> 
> This patch will add extra debug, including subvolid and full "btrfs
> qgroup show" output.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
