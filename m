Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAE9C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Apr 2022 15:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348919AbiD1PTu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 Apr 2022 11:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348946AbiD1PTs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Apr 2022 11:19:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AC9AFAE8
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 08:16:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 537D161F41
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 15:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7389DC385B0;
        Thu, 28 Apr 2022 15:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651158992;
        bh=FGqBUcTN5gk/VnU6gAXInm4V3TsEBwfS/ORrAylSkmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G7vhDTsPl4DEk95oPL+H8vlkXsZQX1WLrjU6mfckwSyTC0VP23CFyY6pnZtOUM0as
         KEHHk1wTdGQa2o+0L1VqHo9AD9gNUvZSIQc1geCayrYWnykS+iB8RryOEdlNNCIOPf
         r1oefDF5QeS889voMmPjuLGnLfl7fMdnwgF7axkNdj8X8Uy9QGmxb/m9tHYh0cmdnl
         cZG1avEKGvdRT05q/AgkfBLFo6kMCpHS7KPm2gLAhBJ1io2hYgtNSq/sjezVs7TBXP
         aULi9YcocjwvWI+ICPWglIjsglSPcP8DKhoMCYOLrPU7DAaPUj4EtKkO+OJL4HWeKu
         cS5uf9ArEn6/w==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 04/11] utils: add missing global.h include
Date:   Thu, 28 Apr 2022 17:15:52 +0200
Message-Id: <20220428151559.947144-5-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220428151559.947144-1-brauner@kernel.org>
References: <20220428151559.947144-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=823; h=from:subject; bh=FGqBUcTN5gk/VnU6gAXInm4V3TsEBwfS/ORrAylSkmY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRlrV/Ee3ziyvAtLfEXFl3NWrEmJOPIq38HrKWP2T/9e1Cl I9LzYkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE3m9l+Ke81u5m44WZ7oLHWnc5hl TdVz94O7Qka6Lur2kWbwtXvRdgZLjeZ7BX7E2FR9hbp6n/z074ZHBihfFT89fpxnt8P3895sgAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Make sure that utils.{c,h} have access to the necessary defines created
during the configure stage when building xfstests.

Cc: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests <fstests@vger.kernel.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 src/vfs/utils.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/vfs/utils.h b/src/vfs/utils.h
index 06247ec7..ccf2cefb 100644
--- a/src/vfs/utils.h
+++ b/src/vfs/utils.h
@@ -3,6 +3,8 @@
 #ifndef __IDMAP_UTILS_H
 #define __IDMAP_UTILS_H
 
+#include "../global.h"
+
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
-- 
2.32.0

