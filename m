Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1212C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Dec 2022 08:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiLLICP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Dec 2022 03:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiLLICN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Dec 2022 03:02:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E80DEB0
        for <fstests@vger.kernel.org>; Mon, 12 Dec 2022 00:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670832078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=LAb3JTnqC2Rt0QbOhwA5g+VvZUll4k3InXwUki0ojMo=;
        b=LFOIcmUhWMWkfIHy1uKtBuAO3LpGfQENksEihnUqi4+v7451eJ5njoHmM2DlFwGoRPMW5S
        Ubo3M7lFNVZ5U+5mzd+0030L3jdeRcfab+UsV1GC/8RzjZJ3JTX+wSztgJIdmMVfI7glpx
        r/BM7lRpKlVuE2AjyjLQuAhkfs9NOBM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-475-tZGtF1GkPPKGhft1HqbfIw-1; Mon, 12 Dec 2022 03:01:17 -0500
X-MC-Unique: tZGtF1GkPPKGhft1HqbfIw-1
Received: by mail-pj1-f71.google.com with SMTP id x17-20020a17090a8a9100b002196a3b190cso11646832pjn.6
        for <fstests@vger.kernel.org>; Mon, 12 Dec 2022 00:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAb3JTnqC2Rt0QbOhwA5g+VvZUll4k3InXwUki0ojMo=;
        b=q12OHOJ2lf7Rp5CPFaw4gmPL/kTeVBeoCoAKA/UC+YTKz1LM6Hhn35+iA+kGg2q92R
         0XMSXxxYUr+ntBbKaDEwq5p6Tm6KOnCfRnWRTMIOGUQLNVvHs8Joq7XOBvxkK15ZYTFn
         jUpZWd5PzyGnW8Y8cGvOknEmNXRXSd8EUcmR+h0T1tKbZnuiS+Guyot6/wRHz4kiyh+z
         d5UgjTnhCtwvBiUMIce4G95RFJcImpABPhDkULIllfGw7kE5K/3g4xQz8N1dRebi9HA6
         aqFTigjxeeDrYo53ssjlzel2j3uVVV9SaR6qxd5hIEQyeldGpsdQPr2/L6ePhKkxttyC
         xwpg==
X-Gm-Message-State: ANoB5pnOZpjIhurGeLXPMW0RADD+jQ6xZk/cMl5g/odtQoPUXr2M8Gy6
        Iz4Bvh4RLYpwZBnTc+jwi9/2KAvTFQNWVEcMsRiUnAZRpc10+MG5nPf4AECQ7cEJl6H9uo6Gooe
        Ks4JJZUA7DzWEbGKCucE5zak0BqThLWuuC9rks0l2+Jbijmxsi+gx0vf8J1flcRknyg==
X-Received: by 2002:a17:90a:7381:b0:219:bd64:8e60 with SMTP id j1-20020a17090a738100b00219bd648e60mr15486349pjg.34.1670832076142;
        Mon, 12 Dec 2022 00:01:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5ATS+gDU0dlD0FoR3zwwdig6iGVrMy6dT8albPrenrWJ9CR6NyNWFICebpU5TU+6lVYDFjuw==
X-Received: by 2002:a17:90a:7381:b0:219:bd64:8e60 with SMTP id j1-20020a17090a738100b00219bd648e60mr15486315pjg.34.1670832075697;
        Mon, 12 Dec 2022 00:01:15 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r4-20020a17090b050400b00218cd71781csm4764437pjz.51.2022.12.12.00.01.14
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 00:01:15 -0800 (PST)
Date:   Mon, 12 Dec 2022 16:01:12 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: My [ANNOUNCE] emails might be blocking somewhere ...
Message-ID: <20221212080112.2gt3pp5v7hwmvqlb@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi folks,

I've updated fstests to v2022.12.11 yesterday, you can check the for-next
branch to get it, that tag has my signature if you want to check.

I tried to send [ANNOUNCE] emails, my msmtp told me it's send it and exit
0, but I can't see it on fstests@ list, even half day past. I've tried
several times, but still can't see it. I can send it to myself by testing,
but can't see it on fstests@ list. I'm trying to dig into this problem, not
sure what's blocking my emails, so just inform by this email.

Thanks,
Zorro

