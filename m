Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC69C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Sep 2021 08:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47A26108D
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Sep 2021 08:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348160AbhIHIiZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Sep 2021 04:38:25 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21649 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348087AbhIHIiZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Sep 2021 04:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631090237; x=1662626237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6/Tn1yVc+WTofQ4NhLWDvM5b3VB0aZhaPVq9TopzR5U=;
  b=TE6wvE3zSDhly9hdeWTmmPngH8jRgCsqoJiv0ahMed3iXmi+0puB0VnT
   owX2KKJrOiAVjT8KM2rQ+pr9c6oUZ1+4xp3uBNjkVAWo6eu8UBZBrZ0Qz
   TogPD8BH3OW4ShQoA8rN9lLvGPlz3f+rYLBzHec7+2Jt2v4LI8XhL/NMm
   IYSlko/2sFNuH4ZbvLsA7XXxzbJ8ZNMBoRJfFs/17wu3Jv2ZcUZWTG+Hz
   lSpRV8YhwRGAyhSAyEpAwndtxlvbgU2qLVasPyN1ZrWLiCdPaDtYfAnfU
   O26DFs/wBulEsP0SA7O/sQO4DghutmGzYDjwa912yYgJHXYMV+drO1VOB
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,277,1624291200"; 
   d="scan'208";a="291070120"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2021 16:37:17 +0800
IronPort-SDR: 03l4RQOeJkDuO0fR2Vrbv5ipa6Y4W3T+R2bijva34xeXYlv1l96r9piEPUfjLWSH6kue8taMOu
 8yT30MCQyGxGali5P+2RjniIY+MaWXqGWO+q13I4FPIm1IBZ5miN2lA9z+IL1TdZeAmITJigv1
 4FfoDRo0M2Qpl7SfdSl9STLBE9lSAX0Z5QlE23KnH/Aa1FLBxdAC8DFwJITOdh2/EPKjCGlryT
 8PkByg4o5prXBubwTd/03jSvQcgfEw6fsHEaLAhctui0E/vnYiDRk15UPS2UsD8o00MaOriemk
 QGopGFS5ohNhndTgcZYPC+Ef
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 01:13:53 -0700
IronPort-SDR: O41QgquuZv/GCBLJfP0qOnqsYaapS8qsaSifarxfX8FA59Nu3dNPpy0uA4rJOzUuSLFB5Ddnwr
 96smm53uk99SZNTJk93+kbMUgzJgo8dSuWSWR7XpyIWwcSx21y4aex49+2lE73az9GS2aZ9Eky
 M//EYP0O3DZ1rOKhD4iI3bcbOPnfpRwbf6zjYyjrJ19voi1f+RR+OXr6mm1526tzF+1IIdPVBR
 hTQEJV0SWvYLAZitpASdDtqfT9eu5HFKeGW3xNcNWk+05G3tDB+5E2jwpwz0dUtBnr4CYPmtqb
 +oM=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Sep 2021 01:37:17 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 0/3] fstests: Fix order of _require_scratch* and _require_dm_target
Date:   Wed,  8 Sep 2021 17:37:12 +0900
Message-Id: <20210908083715.1831067-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test cases with dm_target shall call _require_scratch* before
_require_dm_target. However, three test cases generic/628, generic/629 and
btrfs/146 do not follow this rule and result in unexpected failures. The first
patch in this series fixes the failures in generic/628 and generic/629. The
second patch fixes it in btrfs/146. The last patch improves _require_dm_target
to prevent the failure in the future test cases to be added.

The failure was found with generic/628 and generic/629. I checked all existing
test cases and found btrfs/146 also has the issue.

Changes from v1:
* Changed fix approach according to comment on the list
* Added fix for btrfs/146 as the 2nd patch
* Separated improvement in _require_dm_target as the last patch

Shin'ichiro Kawasaki (3):
  generic/{628,629}: Fix order of _require_scratch* and
    _require_dm_target
  btrfs/146: Add _require_scratch_dev_pool before _require_dm_target
  common/rc: Check call order of _require_dm_target and
    _require_scratch*

 common/rc         | 3 +++
 tests/btrfs/146   | 1 +
 tests/generic/628 | 2 +-
 tests/generic/629 | 2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.31.1

