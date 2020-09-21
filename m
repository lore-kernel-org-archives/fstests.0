Return-Path: <SRS0=Zf7U=C6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB85C43463
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 08:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2032151B
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 08:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DW8Fjxuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgIUI4O (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726324AbgIUI4O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Sep 2020 04:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600678573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPft3wuKa2BNheFlAkmkmUZdOVRCF+KqVmXjz2lXRw4=;
        b=DW8Fjxujbyr7I2c3LB0NkM+7q7dti1ASxUeMcUJkRPHg5BUW4XoDEIMn2v91bJp1kESm14
        aAYZVMpPLgds+++n7WkwolLyKj1K/iZIq0hqvQrO0TI6/e3YnpqbioWG552/iIx22IIjB9
        /aaQp7HOIOv3fka+Z6Y55YdJY8kjONk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-mH1FdanHNM6YnzDch1IhYA-1; Mon, 21 Sep 2020 04:56:11 -0400
X-MC-Unique: mH1FdanHNM6YnzDch1IhYA-1
Received: by mail-wm1-f69.google.com with SMTP id x6so3487041wmi.1
        for <fstests@vger.kernel.org>; Mon, 21 Sep 2020 01:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zPft3wuKa2BNheFlAkmkmUZdOVRCF+KqVmXjz2lXRw4=;
        b=bAGZUCBdlL7vf4DHsNO6wjn2gTV/aGzKzO3fMglQfw1wusBbKsxvLBRyGpxQq+yMnS
         1Ynw6UHc3MC+Z0f7Y6lipy5BfdOjmA/ZGt8oRUStBJiaZ33D5WYJHgR4SHgzxCnzRsE+
         KZqJrdRHaeFbUAX21QbSkSBrr5vceIKSiOf2LE+lU16q7vR6BwHbJGuZqspo43wURivl
         S0YeUtqbzyXAXZFOLceCC58ehEmKHPVtcSTeG6yZj7vL1lVBkrXP/k3NXbtI5T6VKEQ4
         FLQ2hBDNvrRQxTKnNO1AHSJg3p9mKiQvByn4b4hs/dmVhYFya+TzDaccJ6TLy5Wrz3zq
         e64Q==
X-Gm-Message-State: AOAM531Ur4H91RBJdrs59Vx9DiqxGw1cf0yB7Vou8CvR29l3XhqOd968
        DFtH4LZIQQYSLbulXoo1+enBCxi7o3OwQ8aMot+bAi0C624IRgYBtqj1v2wykQHXytcHLx/I+22
        1bueMWh9m1Gj/6RBv4A==
X-Received: by 2002:a7b:ca56:: with SMTP id m22mr27414544wml.12.1600678570019;
        Mon, 21 Sep 2020 01:56:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGUj27jQjsV28V9zp2q5cmdLXUl5X7wYLHIY2dsLyahfOyi2vLzba/9rUTEMapFaUFLBXzvQ==
X-Received: by 2002:a7b:ca56:: with SMTP id m22mr27414524wml.12.1600678569806;
        Mon, 21 Sep 2020 01:56:09 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id e1sm20481223wrp.49.2020.09.21.01.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 01:56:09 -0700 (PDT)
Subject: Re: [PATCH v2] xfs: Add test for too-small device with stripe
 geometry
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org
References: <20200918061514.115764-1-preichl@redhat.com>
 <20200920161055.GO3853@desktop>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <a7672d2c-0401-cc45-6bfb-5a9833a50377@redhat.com>
Date:   Mon, 21 Sep 2020 10:56:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200920161055.GO3853@desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Thanks for the comments I hope I have addressed them all in version 3. Bye.

