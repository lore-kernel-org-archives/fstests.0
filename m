Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D153C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Apr 2022 02:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiDZC5x (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Apr 2022 22:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiDZC5w (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Apr 2022 22:57:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CAC11F96E
        for <fstests@vger.kernel.org>; Mon, 25 Apr 2022 19:54:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38DF4B81C06
        for <fstests@vger.kernel.org>; Tue, 26 Apr 2022 02:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1925C385A7;
        Tue, 26 Apr 2022 02:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650941683;
        bh=fF8f4UGwBm2bWLDW3m8dK7PNy2jR7HlAaVz43KfLLA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d2MAHMP/LZGQ3PpoR+m7L2ss3JjeeeVIbIlszvHhXaX2BEbe5+IyGecVY0vNVTV0w
         d4OEYkvUeV3mJexKXErl6bTOH0OiJx+v7fwjseRxurxRDeHe3QbGu7Sj6ltgrYU7D3
         ts6ndD27AO0LZ8fMTBlpTpW6FRoXPOBMWspg63D2AS1GGvyuSgy+o8vlQKU+Ua6Csg
         brBiiR8rPpLGfuMNA0/FvUZHXQR2rP186gbdaZ0kowJvqeKmkqDQirWPfnbyfomvSL
         SLZsfdQXkoqtYYreJbtQTmnMSXKsS4jFePEIhcnnLz9bxvWkPaHcpg9NFN3jwuxNNa
         9d6R65Ly11H/Q==
Date:   Mon, 25 Apr 2022 19:54:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/681, generic/682: add debugging information to
 $seqreq.full
Message-ID: <20220426025443.GH17014@magnolia>
References: <20220425211450.3842888-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425211450.3842888-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 25, 2022 at 05:14:50PM -0400, Theodore Ts'o wrote:
> These two tests are checking whether a non-privileged user causing a
> block allocation while expanding a directory block when over quota
> will fail with an EDQUOT error.  There are three reasons why this can
> fail.
> 
> * Aa test bug, where if the file system is using cluster allocation
>   (for example, ext4 bigalloc) the test doesn't add enough directory
>   entries to actually force directory grwoth.
> 
> * A file system bug, where the file system allocates blocks but for
>   some reason isn't charging the space quota correctly (which
>   currently seems to be the case in ext4 with fscrypt).
> 
> * A file system bug, where the file system is correctly charging the
>   space quota to the unprivileged user, but isn't failing the system
>   call with EDQUOT.
> 
> By adding some additional debugging information about whether
> directory has grown or not (in addition to the existing repquota
> output) to the the $seqres.full, it makes easier for the file system
> developer to disambiguate between these possibilities.  It's cheap to
> do this, and it could save developer time when trying to root cause
> the failure.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Cc: Darrick J. Wong <djwong@kernel.org>

Sure, why not? :)
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/681 | 4 ++++
>  tests/generic/682 | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/tests/generic/681 b/tests/generic/681
> index 2baae9f4..090da795 100755
> --- a/tests/generic/681
> +++ b/tests/generic/681
> @@ -50,6 +50,8 @@ echo "set up quota" >> $seqres.full
>  setquota -u $qa_user 0 "$((blocksize / 1024))" 0 0 $SCRATCH_MNT
>  chown $qa_user $scratchdir $scratchfile
>  repquota -upn $SCRATCH_MNT >> $seqres.full
> +echo $(ls $scratchdir | wc -l) files in $scratchdir  >> $seqres.full
> +ls -sld $scratchdir  >> $seqres.full
>  
>  # Fail at appending the directory as qa_user to ensure quota enforcement works
>  echo "fail quota" >> $seqres.full
> @@ -60,6 +62,8 @@ for ((i = 0; i < dirents; i++)); do
>  	test "${PIPESTATUS[0]}" -ne 0 && break
>  done
>  repquota -upn $SCRATCH_MNT >> $seqres.full
> +echo $(ls $scratchdir | wc -l) files in $scratchdir  >> $seqres.full
> +ls -sld $scratchdir  >> $seqres.full
>  
>  # success, all done
>  echo Silence is golden
> diff --git a/tests/generic/682 b/tests/generic/682
> index 31629a56..b4cd0cd9 100755
> --- a/tests/generic/682
> +++ b/tests/generic/682
> @@ -51,6 +51,8 @@ echo "set up quota" >> $seqres.full
>  setquota -u $qa_user 0 "$((blocksize / 1024))" 0 0 $SCRATCH_MNT
>  chown $qa_user $scratchdir $scratchfile
>  repquota -upn $SCRATCH_MNT >> $seqres.full
> +echo $(ls $scratchdir | wc -l) files in $scratchdir  >> $seqres.full
> +ls -sld $scratchdir  >> $seqres.full
>  
>  # Fail at renaming into the directory as qa_user to ensure quota enforcement
>  # works
> @@ -64,6 +66,8 @@ for ((i = 0; i < dirents; i++)); do
>  	test "${PIPESTATUS[0]}" -ne 0 && break
>  done
>  repquota -upn $SCRATCH_MNT >> $seqres.full
> +echo $(ls $scratchdir | wc -l) files in $scratchdir  >> $seqres.full
> +ls -sld $scratchdir  >> $seqres.full
>  
>  # success, all done
>  echo Silence is golden
> -- 
> 2.31.0
> 
