Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E3FC54EE9
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 07:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiITHfb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiITHfW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 03:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30975D0FE
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663659320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=imjo6QDuippFQitNqOx4XVtygC5zhQSbfNDOJj+GdYU=;
        b=DshbzxyKiF4mqiqFr/nFulK1AQpDCg4fAa2zbkfowcUeFqqvIZ1fGxOGJcJ1ezL4n2BDY0
        sDLJzN63ZjORIXD83Gs7W9eQcX9siYsWgQZ5znvP91snf408PIaHownR1T0XfWLWa9105P
        fKNwdLyCuZ55pMNTI4ItnbhcofqRxP0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-53-KHqdPuFROiKhtKtBC2Kvvw-1; Tue, 20 Sep 2022 03:35:18 -0400
X-MC-Unique: KHqdPuFROiKhtKtBC2Kvvw-1
Received: by mail-ej1-f71.google.com with SMTP id he41-20020a1709073da900b00780bff831ebso880195ejc.6
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 00:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=imjo6QDuippFQitNqOx4XVtygC5zhQSbfNDOJj+GdYU=;
        b=6B1syTYyEtebbvjVqu8EynKs6dWpWosEPgRU8L2nZbennpejSUl+DEY5Eu9Rq2K4Fe
         jRR9jsggYK1JcSI1NhtUboNWLbAnvOp/1lniH/+lvbFawYb7OOsLTWzhvGWiEOAfJoE4
         ltKyD5P5BAgZkSGwq7DRrrxmYkPYkShvgwNMgGeJKAH8WeWLPaDx9fgNRRokMRQ2hYp3
         CYg1voCeZcDnI/sVXsmjtVPTlNjjZxesFV+rXNutvTV8T1syExSsGHvtaMD+HC6MeqsA
         i5j396oQYX+YP6YIuo3tx7YozM0yKlRIi5g6sleVgRdZaMFVC6b4ChY3l2e9E+5qnLxU
         Wxlw==
X-Gm-Message-State: ACrzQf19R9kUJFQqY8VMv607iaoinfnn3/CvW1FZgrK/99Tk+b6TJJRJ
        OLwj87f8hkQaXGUFTczdV9Ny4kaBjJ1A66tp3sZSbF7OlJ+oAZJE83zruq40dzOYchrwPGchPsH
        VUQ2+4t/qi2JDlEXTta2DwhRe6kwHkpM5ej7NR93G8nWUTD4H6uX6UKRY6qUlhCwbiTnF
X-Received: by 2002:a17:907:16a5:b0:77c:e0f0:1f25 with SMTP id hc37-20020a17090716a500b0077ce0f01f25mr15478301ejc.217.1663659316816;
        Tue, 20 Sep 2022 00:35:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4EPodk1gi+T7JvAA8Ft4EK+ned/N+lj8WwdxlXhK8A0istOyN8pjPOg8wB2ref49rXnZoJMw==
X-Received: by 2002:a17:907:16a5:b0:77c:e0f0:1f25 with SMTP id hc37-20020a17090716a500b0077ce0f01f25mr15478288ejc.217.1663659316595;
        Tue, 20 Sep 2022 00:35:16 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id y8-20020a50e608000000b0043d1eff72b3sm733479edm.74.2022.09.20.00.35.15
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 00:35:15 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v3 0/2] generic: test i_blocks for truncated largefiles
Date:   Tue, 20 Sep 2022 09:35:12 +0200
Message-Id: <20220920073514.285136-1-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Please see next revision of the patch set.
Please do not hesitate with proposing better name than
create_sizedfile() or better place for its definition.
Thank you.

*Time taken before falloc optimization to run on my system*

* fs: ext2
generic/694 8s ...  7s
generic/698 9s ...  10s
Passed all 2 tests
* fs: xfs
generic/694 7s ...  11s
generic/698 10s ...  7s
Passed all 2 tests
* fs: btrfs
generic/694 11s ...  6s
generic/698 7s ...  7s
Passed all 2 tests
* fs: exfat
generic/694 6s ...  8s
generic/698 7s ...  9s
Passed all 2 tests

*With falloc optimization in place*

* fs: ext2
generic/694 8s ...  7s
generic/698 9s ...  7s
Passed all 2 tests
* fs: xfs
generic/694 7s ...  0s
generic/698 7s ...  0s
Passed all 2 tests
* fs: btrfs
generic/694 0s ...  0s
generic/698 0s ...  1s
Passed all 2 tests
* fs: exfat
generic/694 0s ...  8s
generic/698 1s ...  9s
Passed all 2 tests
[preichl@f32 xfstests-dev]$ 


V3
* introduced create_sizedfile() helper
* amended g/694 and g/698 to utilize this helper

Pavel Reichl (2):
  common: new helper to alloacate fixed size files
  generic: test i_blocks for truncated large files

 common/rc             | 13 ++++++++++++
 tests/generic/694     |  2 +-
 tests/generic/698     | 47 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/698.out |  2 ++
 4 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/698
 create mode 100644 tests/generic/698.out

-- 
2.37.3

