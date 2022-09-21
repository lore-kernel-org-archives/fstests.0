Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7CEC32771
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Sep 2022 14:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiIUOKt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Sep 2022 10:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiIUOKl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Sep 2022 10:10:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CE78E4F2
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 07:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663769431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Kj8xYkIG9PGl97JchHJj7VNuyYhDeHnjp5dkeNas5iY=;
        b=BryaB5LE+PL6z9mtgohrRK+KUAX/jjHIwzMV66IxyehTeDbPcDy6xWwFXT+Ow2to4DBssK
        EqPbTk3q2KLvknvpCAwzjORLxYe3F1tMv0CGqsxM2HidISi419CaKp1iccs89+POLyg3Wk
        NuyJfv8GVjzfMXzP0Uq+sEBnqmafn6Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-x8ZJS1MlNYeYTwOveVNBtg-1; Wed, 21 Sep 2022 10:10:29 -0400
X-MC-Unique: x8ZJS1MlNYeYTwOveVNBtg-1
Received: by mail-ed1-f71.google.com with SMTP id dz21-20020a0564021d5500b0045217702048so4483115edb.5
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 07:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=Kj8xYkIG9PGl97JchHJj7VNuyYhDeHnjp5dkeNas5iY=;
        b=QMeMmkXls6PzA3BiOmx7AyQzlkd9rHj5otuQnSpRUmJguaPwBGnkG0BLPCxUOaYT5l
         IgvIUE3Y+3V2ICk6Im/9YXc4jqkqeX3esedfcxMK1m6cC1+daKADUGKusa6YV93ClzSi
         yJGtXCaHdrPJ2iTbPTLqFE77sru4BUTfPO15UjsiTELIjfK0fWV6gE8vMDQeAuQMVHev
         /13ugv/GztfLeR0+KYf2Lndr1mjhV8+lrVm4xWjEENcSdWUqv8Maka/WBwvWrBFlOeS0
         KP95/GsTL1P98pHAAAA7eyXPZv1sw5c50APR0Zmf7+ZKdbu8QITROcfBE6qhlpFD2IHP
         xX4Q==
X-Gm-Message-State: ACrzQf2DCQD89jJnC3n++pbDqFPjI2VzqpbqlCEtpVZ0Uafrnct0WALH
        NLlp2hSQYcnmaVwYLbxxF07AB6USJf+2nQ3gbPUFaznd1ac5POa8cSzRx6ppNhs+/BaKaUuurrd
        NmvNEgscKXx8nxmeDVYUzwReJohcme/H0kBQvpT6GR9UzW88MvuQBnZIHta311BydTLk6
X-Received: by 2002:a17:907:970f:b0:781:de97:9a42 with SMTP id jg15-20020a170907970f00b00781de979a42mr5279305ejc.81.1663769427672;
        Wed, 21 Sep 2022 07:10:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7jfVCVtr6vunI3PHre0jdjzB9AVDqW/IIUNnQBb4FN2JCecCz51BbFBVi6gKhcJKN5ebAmFw==
X-Received: by 2002:a17:907:970f:b0:781:de97:9a42 with SMTP id jg15-20020a170907970f00b00781de979a42mr5279293ejc.81.1663769427403;
        Wed, 21 Sep 2022 07:10:27 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id mf24-20020a170906cb9800b0077fc446aaf6sm1273400ejb.202.2022.09.21.07.10.26
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 07:10:26 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v4 0/2] test i_blocks for truncated largefiles
Date:   Wed, 21 Sep 2022 16:10:23 +0200
Message-Id: <20220921141025.920599-1-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

Zorro, Darick - thank you for your comments. Please see next revision.

V3
* introduced create_sizedfile() helper
* amended g/694 and g/698 to utilize this helper

V4
* copy-pasted the helper as suggested by Zorro (just proposed a different comment)
* updated the tests to use it and check its return value
* added _fixed_by_kernel_commit directive into g/694


Pavel Reichl (2):
  common: new helper to alloacate fixed size files
  generic: test i_blocks for truncated large files

 common/rc             | 22 +++++++++++++++++++
 tests/generic/694     |  8 ++++++-
 tests/generic/698     | 51 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/698.out |  2 ++
 4 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/698
 create mode 100644 tests/generic/698.out

-- 
2.37.3

