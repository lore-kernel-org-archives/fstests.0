Return-Path: <SRS0=0tij=44=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDB2C0044D
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Mar 2020 17:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B8B20734
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Mar 2020 17:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="AqDvoP/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgCKRrI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:47:08 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:45366 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgCKRrH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Mar 2020 13:47:07 -0400
Received: by mail-qk1-f174.google.com with SMTP id c145so2904259qke.12
        for <fstests@vger.kernel.org>; Wed, 11 Mar 2020 10:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FcqiswfdjqetanoyQsWUUD+OLgI+FTzG1aCM5ZGvWYg=;
        b=AqDvoP/QEi9hL3qxS+Q6NQqdLHK6wx/DwZwjykjXX+QU/8IU6Clrq4p8TaG/id0TTZ
         VyomtFSnvyv/lAeh4Lsmg1f4X9VzpmX3U1PaPKcRtJiGrkWBwBILhR86B/fET7z8uWhm
         BAi2SKbsN6tMiMKt4tPNtR/V6vSjINs8/XjW74rxGbk9rKjYdeBJupFELQUiWSGmAiv4
         0wLmKEwZMoQEICqwWHevYHJZPaGZSVlbwg4CdFk5TNioLZaanqizjQ5o5cIDYM326uA5
         a6ysIE2aKpW+C1jrh+QPJ1DAG78NmMHU26oe/+Ijy2NNf4NuptR4pzpJO7ql4iRttY9n
         wrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FcqiswfdjqetanoyQsWUUD+OLgI+FTzG1aCM5ZGvWYg=;
        b=uOPRfLHQcWRTzjCQIvVebSs3hD88LPmSpgxb4FW1gpaG9YvTVpshUKx8hFizaRYJZ+
         ugGV9TUPd694hzHmrNIAaAqLKWOecLQY/4o7b3VdaMfjZnUMhG+H23evxSIn7ZpAYHim
         0evX4xaKilMWVVyffyUZt6S0If00twRrhNhejIxBpjYteidB8t0+agjPKCWQSGf+PNbK
         NxUpm0ErcOYUH1UyZK8VTq4XleGMKXczT3OXxPZ41mLkJy3drpVAAev7oNyYNE8s76hQ
         BvmWu7SEVGIH45pBpTzjTuqFCu1vBuI+NjCVeU04kP6lQY7T+/8gfqGbN+RBwqdf+G/2
         EkRw==
X-Gm-Message-State: ANhLgQ37upbXN2CTQvrnQ7AuxHee7AwF7Q3uowz/DQKPN74to+6uDsdD
        D0TQymjam3j0O1AA/lU93b8H+g==
X-Google-Smtp-Source: ADFU+vtCpeU37ks6JXcL0kuNFs5hanjYoDYD6WeSows5XS5HyohbXIunN3LiNqne3mdWrFZ6Ea8t9Q==
X-Received: by 2002:a05:620a:6d9:: with SMTP id 25mr3842870qky.457.1583948826431;
        Wed, 11 Mar 2020 10:47:06 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f13sm12113841qte.53.2020.03.11.10.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:47:05 -0700 (PDT)
Subject: Re: [PATCHv4 fstests] btrfs: Test subvolume delete --subvolid feature
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org, guaneryu@gmail.com,
        fstests@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200309103956.1697-1-marcos@mpdesouza.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <085200d5-451b-e58c-0a3b-634d12e0002f@toxicpanda.com>
Date:   Wed, 11 Mar 2020 13:47:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309103956.1697-1-marcos@mpdesouza.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/9/20 6:39 AM, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Now btrfs can delete subvolumes based in ther subvolume id. This makes
> easy for the user willing to delete a subvolume that cannot be accessed
> by the mount point, since btrfs allows to mount a specific subvolume and
> hiding the other from the mount point.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
