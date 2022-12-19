Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43391C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Dec 2022 19:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiLSTD5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 19 Dec 2022 14:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLSTD4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Dec 2022 14:03:56 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AEE185
        for <fstests@vger.kernel.org>; Mon, 19 Dec 2022 11:03:55 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 62so6784159pgb.13
        for <fstests@vger.kernel.org>; Mon, 19 Dec 2022 11:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bSShLd393sz20z+7teqVmz4hsC5xfFmWLeAPr6ZXujc=;
        b=bSGN94DejCsRSoGltQ+tikuwfqCplGOg+rllbHXRi3kWL1pB9lKfAFmFjHp/No7mtE
         ICuaXuE2BdkC3Y0TSFLzn140vqNVicpR4lZrAFthVTYE/HX0FrdwuQexCyUHE9T8U1K8
         RHvQ+KkyPr5ixNk7uW1gmW03aIVnLV6ZEMSM1vEZG3XVMIKvyLNIxN9QL9DuM4TLtw8l
         M1prghGbPJCtGoOaJPxvakeYV5CNi0YIS7DMFlsx9J/10iJVfcda+6qkYnCf29KZVeCW
         pViiwwKO1En85nFqQT02d9iWbC1US3/6BAaZzFlgL+eFrxpmSySv8/mL26SgO4S+aDBl
         TEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSShLd393sz20z+7teqVmz4hsC5xfFmWLeAPr6ZXujc=;
        b=7LlbuAG3KqdQWysRLskHf5XFcknDvGgUFEWtmA8aErc+BMioemcgxpPw39WrFKa7S/
         ul7N1cxhtNUWEYay1MwEYza/To9aPudooaDl+TL2d4WbfPnCDxe0v4QgJzHG7H8giVDA
         Pb5ijBnIU6CABqCiQfXNX4Js1NZda2J7TdcjECXSnSyubbr6AR0IcjIJUpcM8+JHizVi
         ZaFOMGTZWrkFt1U7vu4xKaEdyu5R/p1wPOwVTIuaIvnhf/S12UYyirvCPu8aDTjnqdyq
         fg7TkTQWWwj2CfmmYuufSQqi3ouGkZwpG5E7JhZuGRMJc2omjxiIKcN8F+JXwjijElEW
         qMHQ==
X-Gm-Message-State: ANoB5pl/+H2CeGCD1n0C1Z6wHj0753SH//f3GYuoOGB5N8KXbi8FMtcA
        YjGh0+yc5woxpND62/bcAFw+/HAD/UY=
X-Google-Smtp-Source: AA0mqf7liFUujcIqlYGaEbBSu5xbjYLk1wqgs2sDd6pmcvbdwB4zAYVPzGz3O19IN1NQa5YEWyaipQ==
X-Received: by 2002:aa7:9a0a:0:b0:577:272f:fdb with SMTP id w10-20020aa79a0a000000b00577272f0fdbmr45326883pfj.29.1671476634549;
        Mon, 19 Dec 2022 11:03:54 -0800 (PST)
Received: from google.com ([2620:0:1001:7810:171a:9e98:a79e:8f3c])
        by smtp.gmail.com with ESMTPSA id w10-20020aa79a0a000000b00575afe3c188sm6964280pfj.150.2022.12.19.11.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:03:54 -0800 (PST)
Date:   Mon, 19 Dec 2022 11:03:51 -0800
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] check: wipe tmp.arglist
Message-ID: <Y6C1lyZuJMrjOVzA@google.com>
References: <20221214215926.908628-1-leah.rumancik@gmail.com>
 <Y5tG94XQmBziqveE@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5tG94XQmBziqveE@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Oops, I originally ran into this when I was testing using /var/tmp
instead of /tmp [1], but since we aren't going this route anymore, 
I don't need this for my use case. I am attempting to auto-recover when
a test crashes and relaunch the remaining tests and I was seeing some
tests being rerun due to the lingering tmp.arglist file.

This could occur on the off chance someone's /tmp is persistent or if
there wasn't a clean shutdown, maybe via an OOM kill? Perhaps it is
worth including for consistency's sake. I can update the commit
description if we want to keep it. Let me know your thoughts.

- Leah

[1] https://lore.kernel.org/fstests/20221212230646.4022294-1-leah.rumancik@gmail.com/
