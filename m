Return-Path: <SRS0=0Rk7=6U=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E11C28CBC
	for <linux-fstests@archiver.kernel.org>; Wed,  6 May 2020 18:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D75020735
	for <linux-fstests@archiver.kernel.org>; Wed,  6 May 2020 18:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNriYV8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgEFSwq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 May 2020 14:52:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47045 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729882AbgEFSwp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 May 2020 14:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588791164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gAUEejfR9xy6FM3Qn8uEYUCXUl5z+HqCSLvPitvABUc=;
        b=LNriYV8CqyS/lctOiLVgmRNnZfKFnfHj3zNr0Uw2r3sDiOGpXeEdo2PftZG4/Zlimrcvze
        s8qnv/YxsZHYX0gDNdioAgZF7vv0tJ1kribP1WL1jQHooHgNZ4NpC1zIj1vP7FbJ0JCaWA
        T6XarpNAsipNT7CkS8oeKziKPqTxf3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-LuwvVi7QNVaG4--5JTipEg-1; Wed, 06 May 2020 14:52:42 -0400
X-MC-Unique: LuwvVi7QNVaG4--5JTipEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BBF7107B79B
        for <fstests@vger.kernel.org>; Wed,  6 May 2020 18:52:41 +0000 (UTC)
Received: from redhat.com (ovpn-113-201.rdu2.redhat.com [10.10.113.201])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E85B3610AB;
        Wed,  6 May 2020 18:52:37 +0000 (UTC)
Date:   Wed, 6 May 2020 13:52:35 -0500
From:   Bill O'Donnell <billodo@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 2/3] fstests: test restricted symlinks & hardlinks sysctls
Message-ID: <20200506185235.GA153719@redhat.com>
References: <99a3164b-ee00-113c-e0aa-41eab9633364@redhat.com>
 <294c5739-ff30-285c-8cf7-11a6dff98294@redhat.com>
 <20200506184437.GB152947@redhat.com>
 <58bb57c3-2a35-3d29-b994-3072307b006b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58bb57c3-2a35-3d29-b994-3072307b006b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 06, 2020 at 01:48:19PM -0500, Eric Sandeen wrote:
> On 5/6/20 1:44 PM, Bill O'Donnell wrote:
> > On Tue, May 05, 2020 at 03:20:10PM -0500, Eric Sandeen wrote:
> 
> ...
> 
> >> +OWNER=fsgqa
> >> +OTHER=fsgqa2
> > 
> > Why fsgqa2 instead of 123456-fsgqa?
> > Thanks-
> > Bill
> 
> Yeah, not quite sure what to do about that.  That username is somewhat specific
> to test generic/381 because it wants to test usernames starting with digits.
> I hate to proliferate required users, though, so not sure what the best way
> to go might be.
> 
> I could maybe/probably use root as one of the users, but didn't want to
> over-complicate it with matching admin privs vs. normal user privs.

Fair enough. THanks!

Reviewed-by: Bill O'Donnell <billodo@redhat.com>

> 
> -Eric
> 

