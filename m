Return-Path: <SRS0=lNUL=EI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6336C00A89
	for <linux-fstests@archiver.kernel.org>; Mon,  2 Nov 2020 20:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBE122243
	for <linux-fstests@archiver.kernel.org>; Mon,  2 Nov 2020 20:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LG1a9fXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgKBU0F (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:26:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgKBU0E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Nov 2020 15:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604348763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ooeibwjq50lI3pwUPVMBpMOlM72QKLefLTwf9q4CUio=;
        b=LG1a9fXP5NqRlnr7qOK3kRj/ZyagMST0/5CjKQk48Y2rRog/mqcKP4BwzpkXWUF5yZLeOw
        2Q+lD58F5StY4b1GCaHnSeXi7vY0QvBqh5Eg19FzT7foqVnl0x0Jq6bWyGAdAG4seYvm7/
        DzdlU1NfBoxocM9Sv2NPbIIthvOfv/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-AHqTUwqIMg6sJs86_nrj5A-1; Mon, 02 Nov 2020 15:26:01 -0500
X-MC-Unique: AHqTUwqIMg6sJs86_nrj5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD099106B817;
        Mon,  2 Nov 2020 20:26:00 +0000 (UTC)
Received: from redhat.com (ovpn-115-147.rdu2.redhat.com [10.10.115.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B1A76198E;
        Mon,  2 Nov 2020 20:26:00 +0000 (UTC)
Date:   Mon, 2 Nov 2020 14:25:58 -0600
From:   Bill O'Donnell <billodo@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH] tests/ceph: add Makefile
Message-ID: <20201102202558.GA398497@redhat.com>
References: <20201101171619.323800-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101171619.323800-1-ebiggers@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Nov 01, 2020 at 09:16:19AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> 'make install' stopped working because the tests/ceph/ directory is
> missing a Makefile.  Add it.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

thanks-
Reviewed-by: Bill O'Donnell <billodo@redhat.com>

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
> -- 
> 2.29.1
> 

