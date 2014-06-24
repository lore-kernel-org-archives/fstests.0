Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:26273 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750709AbaFXE2I (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Jun 2014 00:28:08 -0400
Date: Tue, 24 Jun 2014 14:28:05 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] xfstests: Introduce get_block_size() helper
Message-ID: <20140624042805.GE9508@dastard>
References: <1403535255-14601-1-git-send-email-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403535255-14601-1-git-send-email-lczerner@redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: Lukas Czerner <lczerner@redhat.com>
Cc: fstests@vger.kernel.org, fdmanana@gmail.com
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 23, 2014 at 04:54:14PM +0200, Lukas Czerner wrote:
> Currently many tests and other functions uses it's own way to get block
> size of the file system. Introduce get_block_size(), a generic way to
> get block size of mounted file system and use that instead.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Common helper, needs to be preceeded by a "_". i.e.  _get_block_size()

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
