Return-Path: <SRS0=/bTx=EH=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DBBC2D0A3
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Nov 2020 18:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC4A2224F
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Nov 2020 18:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgKAS20 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Nov 2020 13:28:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:50360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbgKAS20 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 1 Nov 2020 13:28:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69F74AD4F;
        Sun,  1 Nov 2020 18:28:24 +0000 (UTC)
Received: from localhost (brahms.Home [local])
        by brahms.Home (OpenSMTPD) with ESMTPA id 56f819d1;
        Sun, 1 Nov 2020 18:28:33 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] tests/ceph: add Makefile
References: <20201101171619.323800-1-ebiggers@kernel.org>
Date:   Sun, 01 Nov 2020 18:28:33 +0000
In-Reply-To: <20201101171619.323800-1-ebiggers@kernel.org> (Eric Biggers's
        message of "Sun, 1 Nov 2020 09:16:19 -0800")
Message-ID: <87v9epylri.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> From: Eric Biggers <ebiggers@google.com>
>
> 'make install' stopped working because the tests/ceph/ directory is
> missing a Makefile.  Add it.

Yikes!  Sorry about that.  Thanks for fixing this, Eric.

Cheers,
-- 
Luis

>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  tests/ceph/Makefile | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 tests/ceph/Makefile
>
> diff --git a/tests/ceph/Makefile b/tests/ceph/Makefile
> new file mode 100644
> index 00000000..55e35d77
> --- /dev/null
> +++ b/tests/ceph/Makefile
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TOPDIR = ../..
> +include $(TOPDIR)/include/builddefs
> +
> +CEPH_DIR = ceph
> +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(CEPH_DIR)
> +
> +include $(BUILDRULES)
> +
> +install:
> +	$(INSTALL) -m 755 -d $(TARGET_DIR)
> +	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
> +	$(INSTALL) -m 644 group $(TARGET_DIR)
> +	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
> +
> +# Nothing.
> +install-dev install-lib:
