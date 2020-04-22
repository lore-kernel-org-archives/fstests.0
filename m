Return-Path: <SRS0=NJCV=6G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7771CC54FCB
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Apr 2020 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6341E2076E
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Apr 2020 17:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgDVRmP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:42:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:63263 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgDVRmO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 22 Apr 2020 13:42:14 -0400
IronPort-SDR: tTBciR64XhezJrQH07P1ozq+tgAZzEc7DSTjw24oCDUtSW/tJC3KgcPyC3KxAz2JXZNkX8r0FK
 2U32DIL5xNgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 10:42:13 -0700
IronPort-SDR: VPYnin76oXayQN/t+qDgfI+nXSdp7OpSLlIOav6ZDGZAi2hp7mIAVzX+SikYHecIZYsXyyMQkO
 KKBP/nvQJsTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="259148014"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2020 10:42:13 -0700
Date:   Wed, 22 Apr 2020 10:42:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4: ext4 mount sanity test
Message-ID: <20200422174212.GK3372712@iweiny-DESK2.sc.intel.com>
References: <20200422152012.28588-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422152012.28588-1-lczerner@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 22, 2020 at 05:20:12PM +0200, Lukas Czerner wrote:
> Add test to validate that the ext4 mount options are properly recognized,
> validated and applied to avoid regression as ext4 moves to the new mount
> API.

When is the new mount API work slated to be done?  I must have missed the patch
set.

Ira

