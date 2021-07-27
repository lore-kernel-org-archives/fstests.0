Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A210C4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Jul 2021 20:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AFAA60F93
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Jul 2021 20:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhG0UKv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 27 Jul 2021 16:10:51 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:55172 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhG0UKu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Jul 2021 16:10:50 -0400
Received: by mail-pj1-f46.google.com with SMTP id b6so1552402pji.4;
        Tue, 27 Jul 2021 13:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kg/ju0I1JrG6XeKBzgXboejkxMZ61/+s/UAjeWoiHrc=;
        b=qmxz9UGAnQSUsMXRYTdSUl4l2l/Fgw3S5NvXA4YYt0yVjwJ1WQJFCoda2dM02c0DK9
         3wlCGYOSEP3zgn1xyr+YjjwOnutT6+hRejqQHGnxoJHM1Ec5ttXQttLCQLdPKGtofI6A
         0ygTXv5T+wSPmDV+CJCIgQHzXyvaBEhteLuH/+99MkGt3dRM/2tx7XFnenuKSfOB3WFe
         zjOdj7j41UGh5zSv3yCKikG5yJX0fMkimGJi0chka74hpwRYSji//O1GKmDLLBWuHL/w
         2ZGdinXdj0GEsqT5C+aAkKZBjdkoVvt2NYQvHQvx4ILNo/qWAtFyq77EhYQ4d9swIEXo
         UY2g==
X-Gm-Message-State: AOAM530IwCmcPMjoO1l/uLD2Erd14Hy93MaY/FL5MHBykA1v2Y1k5qF+
        7xTv1CRWwpuMM2ApwsiDRqvFiSCUYXo=
X-Google-Smtp-Source: ABdhPJxtgprv3sRQ1EJ/rLM8TdGkcxhcs2mq6gaiGYqElotkUtOTJlIT9tiTCCMco2e/aC5+ATkIGw==
X-Received: by 2002:a17:90a:a585:: with SMTP id b5mr18406410pjq.219.1627416648526;
        Tue, 27 Jul 2021 13:10:48 -0700 (PDT)
Received: from localhost ([191.96.121.85])
        by smtp.gmail.com with ESMTPSA id 78sm4660358pfw.189.2021.07.27.13.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 13:10:47 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/4] scsi_debug: improve failure rates
Date:   Tue, 27 Jul 2021 13:10:41 -0700
Message-Id: <20210727201045.2540681-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When using scsi_debug to create virtual devices we can often run into
failures which are really just false positives, and the failure was the
inability to remove the module. Addressing this is not easy. While we
can learn from what blktests folks do and use udevadm settle, that's
not sufficient by any means. This addresses the other pieces needed.

More work is also needed on the scsi_debug driver front.

Makes me wonder if a patient kmod removal option is then desirable
upstream on kmod (just the one which waits to refcnt 0), given this sort
of test case. Lucas?

Luis Chamberlain (4):
  common/config: disable udevadm settle if CONFIG_NET is disabled
  common/scsi_debug: use udevadm settle instead of sleeping
  common/module: add a patient module rmmod
  common/scsi_debug: use the patient module remover

 common/config     |  9 ++++++++-
 common/module     | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 common/scsi_debug | 10 ++++++----
 3 files changed, 62 insertions(+), 5 deletions(-)

-- 
2.29.2

