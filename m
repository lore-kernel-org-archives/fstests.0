Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2003CC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Jan 2022 20:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiASUNl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Jan 2022 15:13:41 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50639 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231740AbiASUNl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Jan 2022 15:13:41 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20JKDJcN005374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 15:13:19 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0C77415C40F6; Wed, 19 Jan 2022 15:13:19 -0500 (EST)
Date:   Wed, 19 Jan 2022 15:13:18 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Andrew G. Morgan" <morgan@kernel.org>
Cc:     Cristian =?iso-8859-1?Q?Rodr=EDguez?= <crrodriguez@opensuse.org>,
        "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        Florian Weimer <fweimer@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Message-ID: <Yehw3pm/+2B7JKxR@mit.edu>
References: <YeYmzJG5M0y9BcMc@mit.edu>
 <61E6298D.80006@fujitsu.com>
 <YeY6Uh8I7RlsCicw@mit.edu>
 <61E64FED.2010906@fujitsu.com>
 <87r195i1lq.fsf@oldenburg.str.redhat.com>
 <61E7AC82.8080801@fujitsu.com>
 <61E7BBD6.3010706@fujitsu.com>
 <CAPBLoAf9MDA4u_PerRVd25gx0hg4tEH+AUkPyo48Vj5qAaV+0w@mail.gmail.com>
 <CAPBLoAc3H_+aZbZTakODK9Azz7qvpc_SnCh4U5Jxfx0TWKcDsg@mail.gmail.com>
 <CALQRfL4wBQc_tT3b8daivFh7nxad0kfhG7MM2Nx=_nHJ-myphQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALQRfL4wBQc_tT3b8daivFh7nxad0kfhG7MM2Nx=_nHJ-myphQ@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 19, 2022 at 06:50:41AM -0800, Andrew G. Morgan wrote:
> Thanks for finding this.
> 
> Fixed in:
> 
> https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/?id=f25a1b7e69f7b33e6afb58b3e38f3450b7d2d9a0

Thanks!

FWIW, I agree that we should not have depended on it being initialized
to zero at the beginning program.  It was just wierd since it wasn't,
and I was wondering if it was some exotic (musl, dietlibc) C library
that was triggering it --- and then was surprised when it turned out
to be glibc.

The Jon Postel principle of "Be conservaive in what you send, and
liberal in what you accept" is good one to follow, so while it's nice
to some userspace programs that might not be as well-behaved as to not
depend on the status of errno when main() is called, we should fix the
calling program in xfstests as well.

Cheers,

						- Ted
