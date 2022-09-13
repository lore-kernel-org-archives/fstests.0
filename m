Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A99C54EE9
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Sep 2022 12:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiIMM6K (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Sep 2022 08:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiIMM6I (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Sep 2022 08:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1463521805
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663073887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5mSXDrkbPVRnddfFubHohxuagYX2cr9oBXF4kPPYpn0=;
        b=EH4q7rWVxY3fi27fRkbiH8boOEr7t+H9t85CacaPbi6ohacik/yfGGTjisasbCCb0s8OIg
        lubZmsmv96hGkkocaj+8o9ZRAfG4PctvI/wXfyEcIy5UqdLec7/84BZpOhKUW12sZcuaL2
        k8emuu3sj8AxQJhvav3JKlOR5YHJQlM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-flw34P9aNmO3EeV_CXWtHw-1; Tue, 13 Sep 2022 08:58:05 -0400
X-MC-Unique: flw34P9aNmO3EeV_CXWtHw-1
Received: by mail-ej1-f70.google.com with SMTP id gv43-20020a1709072beb00b0077c3f58a03eso2390175ejc.4
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 05:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=5mSXDrkbPVRnddfFubHohxuagYX2cr9oBXF4kPPYpn0=;
        b=4pM41KFKN8FL8eYSdDkRuWZAHmo09BZVyprXL7mZ3alN76sszIYE81E9KNF1jnMiP5
         Re9L28zzOjfC2TjINj3FumNeYkvIFJ3Eyg/gNt2R9rrq7uePA0PEigUIVcocsWyBLoXu
         1s19X2eyfVba2W218izmcL/kM2IIU39I1EO/KJII2QSDdTaI+bejj6yJ6TGNRlO7d1bt
         V/tN4YmzgRwsY/424jC6x/zXRuavODyskSoegy8jhnfyommgktOOguhwFlPDjFP1ylra
         pvWULRW34dQxe48K21WUGlr+zH34U2r81BSLMCM6d9XrLJjF5coKi6gLmcH2iCn8X+hl
         uaJA==
X-Gm-Message-State: ACgBeo3VEpNiuYiekYAZUpu2qsG7FBmAEPvXb8o6uRUKbCyoDHqkFaj7
        VqcH3zpqEcE17CARHpwG/jSlXVnNqOAZIAzw4NiGvu/U8DLwoYsLtWnVJaHYVHZK/W3xMoAf92H
        D8CWhNxzxTxiPfoNlR2UTxRZu3z9JmJq8yVvpXsVr6QsO74TXismkEM35egvwUxVAmf/8
X-Received: by 2002:a17:907:7f8f:b0:779:4b9b:d91f with SMTP id qk15-20020a1709077f8f00b007794b9bd91fmr15501562ejc.323.1663073884114;
        Tue, 13 Sep 2022 05:58:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR61F7kY86ji3d91m7tKSzHebMEWh4V7LPyjhKw4rLQC0JpnZdY81SR2/qX1jDaM728boxpmJg==
X-Received: by 2002:a17:907:7f8f:b0:779:4b9b:d91f with SMTP id qk15-20020a1709077f8f00b007794b9bd91fmr15501546ejc.323.1663073883832;
        Tue, 13 Sep 2022 05:58:03 -0700 (PDT)
Received: from localhost.localdomain.com (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id e17-20020a170906249100b00778e3e2830esm593722ejb.9.2022.09.13.05.58.02
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 05:58:03 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2 0/1] generic: test i_blocks for truncated large files
Date:   Tue, 13 Sep 2022 14:58:00 +0200
Message-Id: <20220913125801.56366-1-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

thanks for the comments on version #1 and sorry for a late reply
- I was on a vacation.

I updated the test as suggested and worked around the EXT2 fail using 
"_within_tolerance" and 1% as the tolerance...I have a mixed feelings
about this - it's not supported by any math, just a magic number to
avoid false positive. Any thoughts?

Thanks!


Pavel Reichl (1):
  generic: test i_blocks for truncated large files

 tests/generic/698     | 48 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/698.out |  2 ++
 2 files changed, 50 insertions(+)
 create mode 100755 tests/generic/698
 create mode 100644 tests/generic/698.out

-- 
2.37.3

