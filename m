Return-Path: <SRS0=0Rk7=6U=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E17AC28CBC
	for <linux-fstests@archiver.kernel.org>; Wed,  6 May 2020 18:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E7F20736
	for <linux-fstests@archiver.kernel.org>; Wed,  6 May 2020 18:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQ3fa1Eg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgEFSf2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 May 2020 14:35:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57150 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729757AbgEFSf2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 May 2020 14:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588790127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5dbKNBbIu92vmOhezi6gfjcb7stwUXDJ+ShbVJmo6i8=;
        b=ZQ3fa1Egqe/cBF3xWtIeeiD7dBzp0Rif3nAmf1+usj9fvL7upUKnOS+nUizjiWX51cxw3g
        E5YuJnOsA5v7RqaJq5Dry5ZiZ5ch2W3EQgX/z/RlclKo0Q5tzhFspBZy7MfRo1A8rpnQ0z
        yINdOxhzNT9MJxu+lLOlMNrvVedUBZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-ik0TooHHO2O8rXb6Rm_gSg-1; Wed, 06 May 2020 14:35:25 -0400
X-MC-Unique: ik0TooHHO2O8rXb6Rm_gSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F876835B40
        for <fstests@vger.kernel.org>; Wed,  6 May 2020 18:35:24 +0000 (UTC)
Received: from redhat.com (ovpn-113-201.rdu2.redhat.com [10.10.113.201])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0600A19451;
        Wed,  6 May 2020 18:35:21 +0000 (UTC)
Date:   Wed, 6 May 2020 13:35:19 -0500
From:   Bill O'Donnell <billodo@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 1/3] fstests: add _require_sysctl helper
Message-ID: <20200506183519.GA152947@redhat.com>
References: <99a3164b-ee00-113c-e0aa-41eab9633364@redhat.com>
 <2989bb14-5d77-5e91-d415-2a5bdfcff7a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2989bb14-5d77-5e91-d415-2a5bdfcff7a6@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 05, 2020 at 03:17:38PM -0500, Eric Sandeen wrote:
> New _require_sysctl test to ensure that the sysctl we wish to test is
> available on the system.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

Reviewed-by: Bill O'Donnell <billodo@redhat.com>

> 
> diff --git a/common/rc b/common/rc
> index 2000bd9d..2734dbf6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4208,6 +4208,12 @@ _require_bsd_process_accounting()
>  	$ACCTON_PROG off >> $seqres.full
>  }
>  
> +_require_sysctl()
> +{
> +	name=$1
> +	sysctl $name &>/dev/null || _notrun "$name sysctl unavailable"
> +}
> +
>  init_rc
>  
>  ################################################################################
> 

