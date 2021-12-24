Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A0EC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Dec 2021 04:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245534AbhLXEDE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Dec 2021 23:03:04 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59534 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235118AbhLXEDD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Dec 2021 23:03:03 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BO42vYi020233
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 23:02:58 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 75C4B15C00C8; Thu, 23 Dec 2021 23:02:57 -0500 (EST)
Date:   Thu, 23 Dec 2021 23:02:57 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [xfstests-bld PATCH] setup-buildchroot: make sure chroot dir is
 given mode 0755
Message-ID: <YcVGcV7Wk40FIEq/@mit.edu>
References: <20211223234759.173181-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223234759.173181-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 23, 2021 at 05:47:59PM -0600, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make setup-buildchroot work when the umask is set to 0077.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
