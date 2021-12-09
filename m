Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07292C433F5
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Dec 2021 11:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbhLILVh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Dec 2021 06:21:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49356 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhLILVh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Dec 2021 06:21:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 143FB210FF;
        Thu,  9 Dec 2021 11:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639048683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MvWlQbK9jP1LJNBPnQEH7qoV3WbSzqCO5qeC/NSc+7M=;
        b=zA8+gAGry9dBz2Wbgnnz8cvmtDWvAGShLjf98ZZ+6r1igO6jNlvPvlbxmZMremTtEET8mb
        eHKlLkZhuOHia4lhdAYZeFgYvRyS1FLn5ifrOLUW3XALpEcGW7oPkShepmxzHL2fds+Vjj
        Oc8wvI1Rci5lw++ilQ64GY0Kv53eYEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639048683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MvWlQbK9jP1LJNBPnQEH7qoV3WbSzqCO5qeC/NSc+7M=;
        b=kSZml2xMmgELL8zVnPF7dtnehm3oP/aPsR1qYyN9GY3vg43kcOwTtJCezDhE6ww425g+RV
        5jkDBSGz6PTGDLDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CED9513343;
        Thu,  9 Dec 2021 11:18:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d5+cL+rlsWEXQwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 09 Dec 2021 11:18:02 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id a3457cb1;
        Thu, 9 Dec 2021 11:18:02 +0000 (UTC)
Date:   Thu, 9 Dec 2021 11:18:01 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [fstests PATCH] ceph: don't run tests if we can't set a custom
 layout
Message-ID: <YbHl6WCyneP1AWy3@suse.de>
References: <20211207160437.184145-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211207160437.184145-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 07, 2021 at 11:04:37AM -0500, Jeff Layton wrote:
> Some of the coming fscrypt patches prohibit non-default layout changes.
> Skip running the tests that set custom layouts if setting the layout fails.
> 
> Cc: Luis Henriques <lhenriques@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/ceph | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/ceph b/common/ceph
> index ca756dda8dd3..31b169af51b8 100644
> --- a/common/ceph
> +++ b/common/ceph
> @@ -19,7 +19,7 @@ _ceph_create_file_layout()
>  	touch $fname
>  	$SETFATTR_PROG -n ceph.file.layout \
>  		-v "stripe_unit=$objsz stripe_count=1 object_size=$objsz" \
> -		$fname
> +		$fname || _notrun "setting ceph.file.layout failed"
>  }
>  
>  # this test requires to access file capabilities through vxattr 'ceph.caps'.
> -- 
> 2.33.1
> 

Yeah, this is a simple way to skip those tests.  Feel free to add my

Reviewed-by: Luis Henriques <lhenriques@suse.de>

Cheers,
--
Luís
