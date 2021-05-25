Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E3DC2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0079361420
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhEYQwr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 12:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230451AbhEYQwr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 May 2021 12:52:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91E8A61417;
        Tue, 25 May 2021 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621961477;
        bh=FA/d88njzvUtpQeS47K0bKWnsV7h+otECMQtuDimubs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uPjMwNg2feJcxRDPv4lJ685yF6PYK9fV0o4jlxRgOLQh7de1oqIeRD/quKSHwN0q/
         aTopu7P0x4Ug+gtaCsoJTaDivJ2SO9nGhCD6il8ze0hSf5DLA8Po9KL/USFD/ZJspf
         gXTRurG4SbAoQh+GMKJhEf/CrDCeZW6F4AcIFrjghLvShCG8P31rtUrQ+19zQDggXF
         /d0jv6o3K5WPGrD15fUAMt1nm8cnpwwdtuTdPcKkwV5dEJILzsqT8g5RGe4aIBwN/F
         Tvzl9rIJ9zENr+X5tieMEufCZnO4ACuDQdL4yKBTClGIHYaPTEiFMaFbosnc8Ld3D1
         KviNhN8gvc2FA==
Date:   Tue, 25 May 2021 09:51:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH 5/9] generic/123, generic/128, afs: Allow for an fs that
 does its own perm management
Message-ID: <20210525165117.GJ202095@locust>
References: <20210525161926.GF202095@locust>
 <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
 <162194966265.4011860.229488885734976223.stgit@warthog.procyon.org.uk>
 <4143611.1621961055@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4143611.1621961055@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 25, 2021 at 05:44:15PM +0100, David Howells wrote:
> Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > > Signed
> > 
> > Looks ok,
> > Reviewed
> > 
> > (I'll send the rest when the remainder of the SoB comes in. :P)
> 
> Oops.  That should be:
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Ok then. :)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
