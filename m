Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119BBC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 18 Apr 2022 15:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbiDRPtP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 Apr 2022 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345743AbiDRPtC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Apr 2022 11:49:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FB94AE22
        for <fstests@vger.kernel.org>; Mon, 18 Apr 2022 08:19:33 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23IFIvrb010489
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 11:18:57 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E711C15C3EB8; Mon, 18 Apr 2022 11:18:56 -0400 (EDT)
Date:   Mon, 18 Apr 2022 11:18:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 2/3] common: print hints for reasons of test failures
Message-ID: <Yl2BYBA1aPtQRA9p@mit.edu>
References: <20220417174023.3244263-1-amir73il@gmail.com>
 <20220417174023.3244263-3-amir73il@gmail.com>
 <20220418045226.tjzfcerypfmwybh6@zlang-mailbox>
 <CAOQ4uxign3xse8nQeE7OHz8=99igQir-EM0Tga4G_5uii1PvVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxign3xse8nQeE7OHz8=99igQir-EM0Tga4G_5uii1PvVw@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 18, 2022 at 08:26:33AM +0300, Amir Goldstein wrote:
> >
> > The _fixed_by_kernel_commit is fine, just not all cases for kernel patch,
> > some of them cover patch from userspace packages. So you might change it
> > to _fixed_by_upstream_commit, then let its arguments point out the commit
> > from which upstream project.
> 
> I thought about it too and I agree we should have _fixed_by_upstream_commit
> In fact, LTP tests are annotated like this: {"linux-git", "8edc6e1688fc"}.

Sometimes there will be a different fix for stable kernels because the
"proper" fix in upstream is too risky / dangerous / involved.  So it
might be useful to specify multiple commits.

> But I decided that even if and when we add _fixed_by_upstream_commit
> we had better leave the wrapper _fixed_by_kernel_commit for brevity
> because it is by far going to be the most used annotation.
> I can add this helper now or it could be added later.

Maybe allow multiple _fixed_by_kernel_commit where the default is
upstream, and then other git trees can be specified?  e.g.:

_fixed_by_kernel_commit 8edc6e1688fc
_fixed_by_kernel_commit deadbeef1234 linux-5.4
_fixed_by_kernel_commit f00dfeed5678 linux-5.10

					- Ted
