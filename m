Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B6CC6FA8B
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 06:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIVGip (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 02:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIVGip (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 02:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F47B6D1C
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 23:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663828722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4H5GVtByfi+pXDsDkvB/5Yr9VJZy1CbA3ahZNTc9U6I=;
        b=XfiM54srInignqgsyrnuSL/oMDxg5Rd/7nt/NUU8dFc97+cMohirPlGzLHmAI2FKqtiBED
        PXB6dkJdTCEI650zNiqCSHZHveJFc26DgxSNpdOFXDW9h3JVL5F4wyNjFHuk2E6hB7WvIg
        Y64ojxAb/dmQAG0cf585UrNx2Xi6o9k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-278-SMP6zLy9P36t7NlbLA8OPQ-1; Thu, 22 Sep 2022 02:38:41 -0400
X-MC-Unique: SMP6zLy9P36t7NlbLA8OPQ-1
Received: by mail-ed1-f71.google.com with SMTP id z13-20020a05640240cd00b0045276a79364so5939970edb.2
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 23:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=4H5GVtByfi+pXDsDkvB/5Yr9VJZy1CbA3ahZNTc9U6I=;
        b=OOBcKWVZ72kzRcrhstkSvTfETWNgMr10G9Bs0X0gFNA3o7OZRvDcYXnRkelb1GygvF
         XmRC0fcc9shmBOaHTor1X9zFHFB8caWManfd2z/z3Kz1n6+rRo0MU61gJcLEXAmZVmmi
         Tp/s/CrXL7JR5LOpV/QE/MqA35sJ56SP1C9GtfrMLdXTJgM2HrV72Li8TLScWJzykO2j
         MSA25Tx6CCO8IGIoQMbl80x/EykEeHFHP3B09JAWI27pQw0l02wcxhFrsQa/PMtkfk8D
         AEyWGXGpSHpGYo79QdHdgZ6R7KjEaEnG9vzvb+DxtQQMXJZpEdEbGXzONEEWaa018Kyn
         4xug==
X-Gm-Message-State: ACrzQf0SI5KMCg5rswnktTyNbQTnkeW/s3WckHOhpHNeaZ6ctbTRgI9u
        77LIyMuMeqDpiTFXD80/uOk+7mrcagjnc9T3msAAvWmfpsRlqtQQjOob2kUTVOwPHhbfkb/RzW/
        H11FTFVPm9Urra6ZjgBdL92qlEmgjywPRfoYEz75+c/rvpHDrKzZ9UJ31TnL95pCi44oW
X-Received: by 2002:a05:6402:124c:b0:454:61b8:dea0 with SMTP id l12-20020a056402124c00b0045461b8dea0mr1712436edw.200.1663828719263;
        Wed, 21 Sep 2022 23:38:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6NzfBIZuZEAzZ1G2n2N9RSBHGHRcfwky5gJX8xPl+a60La9OUAFDqv5luZobs59iftv9/Lcg==
X-Received: by 2002:a05:6402:124c:b0:454:61b8:dea0 with SMTP id l12-20020a056402124c00b0045461b8dea0mr1712424edw.200.1663828718905;
        Wed, 21 Sep 2022 23:38:38 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id s4-20020aa7d784000000b0044838efb8f8sm3072750edq.25.2022.09.21.23.38.37
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 23:38:37 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v5 0/2] test i_blocks for truncated largefiles
Date:   Thu, 22 Sep 2022 08:38:34 +0200
Message-Id: <20220922063836.974796-1-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

Thank you for your comments. Please see next revision.

V3
* introduced create_sizedfile() helper
* amended g/694 and g/698 to utilize this helper

V4
* copy-pasted the helper as suggested by Zorro (just proposed a different comment)
* updated the tests to use it and check its return value
* added _fixed_by_kernel_commit directive into g/694

V5
* updated helper comment as Darrick suggested
* changed the error message when failure to create test file occurs

Pavel Reichl (2):
  common: new helper to alloacate fixed size files
  generic: test i_blocks for truncated large files

 common/rc             | 23 +++++++++++++++++++
 tests/generic/694     |  8 ++++++-
 tests/generic/698     | 51 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/698.out |  2 ++
 4 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/698
 create mode 100644 tests/generic/698.out

-- 
2.37.3

