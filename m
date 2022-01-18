Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58264C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 03:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343710AbiARD4I (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Jan 2022 22:56:08 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60739 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343700AbiARD4I (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Jan 2022 22:56:08 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20I3u2fY018074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 22:56:03 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 500D015C40F6; Mon, 17 Jan 2022 22:56:02 -0500 (EST)
Date:   Mon, 17 Jan 2022 22:56:02 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Message-ID: <YeY6Uh8I7RlsCicw@mit.edu>
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YeYmzJG5M0y9BcMc@mit.edu>
 <61E6298D.80006@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61E6298D.80006@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 18, 2022 at 02:43:26AM +0000, xuyang2018.jy@fujitsu.com wrote:
> > You're right of course, but out of curiosity, which C library are you
> > using?
> I use glibc-2.34.

Hmm, ok.  I'm using glibc 2.31, and in this particular program, errno
shouldn't have been set by any prior system call.  I'm guessing maybe
it was something in crt0 which ended up setting errno?

						- Ted
