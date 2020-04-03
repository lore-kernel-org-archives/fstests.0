Return-Path: <SRS0=lZLm=5T=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F351AC43331
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Apr 2020 04:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C24207FF
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Apr 2020 04:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585886537;
	bh=5I3A+wMwLEWcgkVKYWhmU8ZcMTe+gpIN9T/0GE6bNwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n3lwJ8/o7n/RNAyvArWaluUFM14+67UN7j46dWBe0i0Jg/m9HSC2yv87DmVd74V8/
	 8wHP8YW9d3LA3I/WM6ZzmDERDIP3raUrWx/5uCvKZrr7lmlgoZpH5j89drr8HEvu/p
	 k0suu3dephUugagca0qjjv3/xRpJ6v7mV8rgZW3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDCECR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgDCECR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Apr 2020 00:02:17 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F20F2078B;
        Fri,  3 Apr 2020 04:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585886536;
        bh=5I3A+wMwLEWcgkVKYWhmU8ZcMTe+gpIN9T/0GE6bNwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xbtsl3jU/mqe3tuSo4DsIUu+yvw6+l0nbBaDV016Ftb6YwhGPtMiY23ROGw5UFlXl
         l34DYTtmIYRNZeoHJWjChqQvM4QnHSa4CIIVWbhuTIPCy0jWyMf8ZvuSqvSANydUns
         AqQRbL/MHYCejzJIJBc5wiFn6xn/vnsYZ1Tp04eQ=
Date:   Thu, 2 Apr 2020 21:02:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] generic: test PF_MEMALLOC interfering with accounting
 file write
Message-ID: <20200403040215.GA11203@sol.localdomain>
References: <20200403033355.140984-1-ebiggers@kernel.org>
 <20200403035657.GK80283@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403035657.GK80283@magnolia>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 02, 2020 at 08:56:57PM -0700, Darrick J. Wong wrote:
> > +_scratch_mount
> > +_scratch_unmount
> 
> _scratch_cycle_mount
> 
> With that fixed,
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 

That doesn't work because _scratch_cycle_mount does unmount, then mount.
This test wants mount, then unmount.

- Eric
