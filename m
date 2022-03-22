Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F9BC4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 15:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbiCVPzf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 11:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbiCVPze (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 11:55:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AF02EF
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 08:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9420561224
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 15:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC58C340F2;
        Tue, 22 Mar 2022 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647964446;
        bh=UOMvMGN0VJq9Awh6x4oWCOzYegj8SKVQpHrJc5inpWA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=g5/vp/NipHgtTkjdVkjTsZa9uh6onF8JjtJKCAM42kjNzGvMvScSXmp3Q3t6Bcw5z
         x0WBlWdTg719Sk5yUQ+1SN9hLipTEk2xbCux88IVXXjvmqTzaaGk+Kw5j3O7aQ14oq
         h2oaplf19Rh0wEBqw/0OvUrYMp+Cwn8XMONOaTgrYpaFc0JTB/0fQJlpafEeOkBTY2
         P62yNMw/VfsN8jl/IyZ55zGt5XCI9gv+2xfr8322wqJvWZdJL0nA/uR02wGc1wgP5g
         Td0gsd0E2vXf35HpUsu+FPhUPYAWWHk/Smaj3Tesk4vcEBnrhmGpI6fHS5a8VW4G/o
         0N8ZM1RUSAsdg==
Date:   Tue, 22 Mar 2022 08:54:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org,
        roman.penyaev@profitbricks.com
Subject: Re: [PATCH 1/2] xfstests: replace hexdump with od command
Message-ID: <20220322155405.GL8200@magnolia>
References: <20220321110341.1323882-1-zlang@redhat.com>
 <20220321110341.1323882-2-zlang@redhat.com>
 <20220322052259.GC1609613@dread.disaster.area>
 <20220322122015.7zd3qgdvvhmefa2y@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322122015.7zd3qgdvvhmefa2y@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 22, 2022 at 08:20:15PM +0800, Zorro Lang wrote:
> On Tue, Mar 22, 2022 at 04:22:59PM +1100, Dave Chinner wrote:
> > On Mon, Mar 21, 2022 at 07:03:40PM +0800, Zorro Lang wrote:
> > > The "od" is one of the most fundamental commands in GNU/Linux and
> > > most Unix-like systems. So we nearly always can count on it, don't
> > > need to check if it's installed.
> > > 
> > > The "hexdump" isn't such fundamental as "od", some systems don't
> > > install it by default. And as "od" nearly can replace all functions
> > > of "hexdump", so let's use an unified command "od" to do the hexdump
> > > job in fstests cases.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > 
> > Looks good.
> > 
> > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > 
> > > ---
> > > 
> > > Hi,
> > > 
> > > As Dave and Darrick suggested, I did this change, I've tested most of cases,
> > > except f2fs/001 and ceph/002, but I think they're good. And I used "od"
> > > command directly in generic/404 and generic/042 for their special reason.
> > 
> > That generic/404 usage is ... strange. Why record md5sums of the
> > encoded hexdump output of the file when you can just run md5sum on
> > the file directly and get the same information?  i.e.
> > 
> > > diff --git a/tests/generic/404 b/tests/generic/404
> > > index f1e8b0a8..939692eb 100755
> > > --- a/tests/generic/404
> > > +++ b/tests/generic/404
> > > @@ -110,7 +110,7 @@ for (( block=3; block<=500; block++ )); do
> > >  	# or blocks are in correct order, this commit:
> > >  	#   2b3864b32403 ("ext4: do not polute the extents cache while shifting extents")
> > >  	#
> > > -	md5=`hexdump -e '16/1 "%_p" "\n"' $testfile | md5sum`
> > > +	md5=`od -An -c $testfile | md5sum`
> > >  	printf "#%d %s\n" "$block" "$md5"
> > 
> > Why isn't this just:
> > 
> > -	md5=`hexdump -e '16/1 "%_p" "\n"' $testfile | md5sum`
> > -	printf "#%d %s\n" "$block" "$md5"
> > +	echo -n "#$block "
> > +	md5sum $testfile | _filter_test_dir
> 
> Yes, I thought about that too, but I can't be sure about it, so tried to keep
> the logic of original code. If the original author doesn't have some special
> reason, I'd like to change it as this way (cc roman.penyaev@profitbricks.com).
> 
> And for the generic/042:
> -       if hexdump -v -e '/1 "%02X "' $file | grep -q "CD"; then
> +       if od -An -tx1 -v $file | grep -q "CD"; then
> 
> I don't know what that "-v" option is needed (cc Darrick). I thought it might just
> waste the time of grep running ?

Probably.  I probably put that in there for debugging purposes and then
frogot to take it out.

--D

> > 
> > Seperate patch, perhaps?
> 
> Sure, if no one object that, I'll change them in separated patch.
> 
> Thanks,
> Zorro
> 
> > 
> > Cheers,
> > 
> > Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> > 
> 
