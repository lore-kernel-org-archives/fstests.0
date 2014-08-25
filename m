Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:50505 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752920AbaHYA6T (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 24 Aug 2014 20:58:19 -0400
Date: Mon, 25 Aug 2014 10:56:59 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] common: add a directory tree for cifs tests
Message-ID: <20140825005659.GW26465@dastard>
References: <1408781763-30127-1-git-send-email-pshilovsky@samba.org>
 <1408781763-30127-3-git-send-email-pshilovsky@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408781763-30127-3-git-send-email-pshilovsky@samba.org>
Sender: fstests-owner@vger.kernel.org
To: Pavel Shilovsky <pshilovsky@samba.org>
Cc: fstests@vger.kernel.org, linux-cifs@vger.kernel.org, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Sat, Aug 23, 2014 at 12:16:03PM +0400, Pavel Shilovsky wrote:
> Signed-off-by: Pavel Shilovsky <pshilovsky@samba.org>
> ---
>  tests/cifs/Makefile | 14 ++++++++++++++
>  tests/cifs/group    |  5 +++++
>  2 files changed, 19 insertions(+)
>  create mode 100644 tests/cifs/Makefile
>  create mode 100644 tests/cifs/group

Add these when you add the first CIFS specific test.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
