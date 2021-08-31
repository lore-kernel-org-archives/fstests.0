Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE243C432BE
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 17:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8901B610CE
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 17:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhHaRGP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Aug 2021 13:06:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32899 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229735AbhHaRGP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Aug 2021 13:06:15 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17VH5BCw024905
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 13:05:11 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D485615C3E7F; Tue, 31 Aug 2021 13:05:10 -0400 (EDT)
Date:   Tue, 31 Aug 2021 13:05:10 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pavel Reichl <preichl@redhat.com>, Murphy Zhou <xzhou@redhat.com>,
        fstests@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] common/rc: fix MKSWAP_PROG quoting
Message-ID: <YS5hRsSXNHYQdUv9@mit.edu>
References: <20210831030426.nwcoelcnshq4wrxx@xzhoux.usersys.redhat.com>
 <20210831052632.p4kaygjeujipo4w5@fedora>
 <3d064e8a-514d-4a98-3db1-0de490107368@redhat.com>
 <20210831134207.aa4e26xuyji4npia@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831134207.aa4e26xuyji4npia@fedora>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 31, 2021 at 09:42:07PM +0800, Zorro Lang wrote:
> 
> Sorry, I reversed the order. I mean:
> 
> $MKSWAP_PROG "$fname" 2>&1 >> $seqres.full | grep -v "insecure permission"

That looks right, although I might have done something like this:

filter_mkswap_stderr()
{
   grep -v "insecure permission"
}

...

$MKSWAP_PROG "$fname" 2>&1 >> $seqres.full | filter_mkswap_stderr

More for the documentation effect rather than the abstraction.  But I
wouldn't insist on it; some folks might consider this to be excess
levels abstraction.

					- Ted
