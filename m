Return-Path: <SRS0=5rAt=6A=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A775AC352BE
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Apr 2020 06:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879A321556
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Apr 2020 06:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvXzMltM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437726AbgDPG5Z (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:57:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45412 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437756AbgDPG5X (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Apr 2020 02:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587020243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ln4Fr28HEVu7j9CKqN6M+6eIBweESe4GkdQGgDfpzbo=;
        b=cvXzMltMlTMPhaZwAJxCwA17y5mLYilF1ajshsLdyZdWyNvYMZ0kJWz2FPdUyckiwkn0xC
        XEKYJyMwP7vMbMGSnYZ+uWMIWiWrrFUkIgd45Bn9il3ModpMhR41mSYQrPeBH4SMTyzV9g
        6ssOMhxkjQOAqidZbmLcHJ7u0wXq01M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-P3OQscNSPXOmUCxnu6284A-1; Thu, 16 Apr 2020 02:57:21 -0400
X-MC-Unique: P3OQscNSPXOmUCxnu6284A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C7558017F5;
        Thu, 16 Apr 2020 06:57:20 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 515AD5DA7B;
        Thu, 16 Apr 2020 06:57:19 +0000 (UTC)
Date:   Thu, 16 Apr 2020 15:09:37 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fstests <fstests@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: Re: [PATCH 0/4 V2] fstests: fix test requirements for exfat testing
 support
Message-ID: <20200416070937.GA14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Eric Sandeen <sandeen@sandeen.net>,
        fstests <fstests@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
References: <9798d553-0bdd-2b8b-ce3b-3c8d2c37936e@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9798d553-0bdd-2b8b-ce3b-3c8d2c37936e@sandeen.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 15, 2020 at 03:16:47PM -0500, Eric Sandeen wrote:
> Running xfstests over exfat reveals a lot of tests don't properly check
> for filesystem capabilities before running, which leads to incorrect
> failures.  This series fixes up several of those.

This version looks good to me now. (Although I'm wondering how's the "5/4"
generated :-p )

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> 
> -Eric
> 

