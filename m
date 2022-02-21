Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1222FC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Feb 2022 20:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiBUU2e (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Feb 2022 15:28:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiBUU2c (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Feb 2022 15:28:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C5EE237CA
        for <fstests@vger.kernel.org>; Mon, 21 Feb 2022 12:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645475288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mHTSbL+1SHJt7CgLpSieeHB5oWVDW4rxlZLPrtP01Y8=;
        b=Bk0QAlNJ1PoEB9VCbf+hBiUu5Th+SsFShqErM95E1pLNDmNFbIcWrFRhL2ct/umdzDanKR
        sQ2UEdatxlgBVEpbWb94Gsi6mvla3FssidLb/MkO3bNeIZPNNwEXBu/9heeZlpr4SYJrZL
        97SiocSu4UJt5PraMTliKoYIJHKbEgw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-iyrPXoOONmeXRuT1tbSEfw-1; Mon, 21 Feb 2022 15:28:07 -0500
X-MC-Unique: iyrPXoOONmeXRuT1tbSEfw-1
Received: by mail-wr1-f72.google.com with SMTP id p9-20020adf9589000000b001e333885ac1so7868380wrp.10
        for <fstests@vger.kernel.org>; Mon, 21 Feb 2022 12:28:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHTSbL+1SHJt7CgLpSieeHB5oWVDW4rxlZLPrtP01Y8=;
        b=Q0QDC0D52BdAC6UQUVsJAGXDZbXIJe5n5WYA4jRlVQWmRd9+KfDb0kzdw+lejFd1gT
         I2qAmppnTCOYsQ7//rrjvyxONA+5jjc7uQJ/1n1R1i+cQ8Iq4aOSH+goaA/QqmyskF/k
         8lGdrmb7QWEeUfM7GwJ+r/bQGYAKP1aJlCWtZhg42mQFOWZZE3y7yI6Qp+VKaffWi2Bx
         +nE/6xesSMULByYntGpbKeogEUZLbde5NUhB59hp2U86o8KKHYqIjHAzQPLMCPBoYISO
         qxWJBLQAGGAh+a1DD9jwseJktPRjJ7Xrj/B69bv7c1Fk6MewtlGUJ50mKVd1le7jA/5w
         /I6Q==
X-Gm-Message-State: AOAM532VXJ/XaKK/+e71nbkqID87P/6kGhzBUj9dKCPCms1VSTal3e43
        pUAWBjFzgb1Xc2tz9+XSfYU1rW5zzZpbq5HERFv+tfPCMZkLCnS5ePxj/5fl/hR+TCgfRh8AGFW
        zm55/XmPlD/h02fCNOeCNQ62f1+fMzMLnsiGPcJ+eMPerZaJSGCwKghGjrKZe739aRJ15
X-Received: by 2002:a5d:5221:0:b0:1d9:2680:5fb with SMTP id i1-20020a5d5221000000b001d9268005fbmr17186520wra.23.1645475285909;
        Mon, 21 Feb 2022 12:28:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOW2DUmC4PnPiQTO9IYVauumzNqvPA1nf+2jrKTVunD9reZB1U3aEadd58SY8dMcMbz0LLhQ==
X-Received: by 2002:a5d:5221:0:b0:1d9:2680:5fb with SMTP id i1-20020a5d5221000000b001d9268005fbmr17186509wra.23.1645475285702;
        Mon, 21 Feb 2022 12:28:05 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b0037c3659a12fsm519367wmq.6.2022.02.21.12.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 12:28:05 -0800 (PST)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH 0/1] README: restructure & format building manual
Date:   Mon, 21 Feb 2022 21:25:57 +0100
Message-Id: <20220221202558.603994-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I'm new to the xfstests, I've tried to set things up for testing and found out
that building manual in the README is not up-to-date and a little bit difficult
to follow as it's not clear which steps are necessary to get started and which
can be skipped.

In this patch I updated installation package list commands and restructured
"BUILDING THE FSQA SUITE" section. Package list is up-to-date for the latest
distors (Ubuntu 21.10, Debian 11, Fedora 35, RHEL 8).

Andrey Albershteyn (1):
  README: restructure & format building manual

 README | 342 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 205 insertions(+), 137 deletions(-)

-- 
2.27.0

