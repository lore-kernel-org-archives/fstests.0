Received: from mx1.redhat.com ([209.132.183.28]:36878 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbbJVGao (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 22 Oct 2015 02:30:44 -0400
Date: Thu, 22 Oct 2015 14:30:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] btrfs/112: add missing _require_xfs_io_command for falloc
Message-ID: <20151022063041.GH3558@dhcp-13-216.nay.redhat.com>
References: <1444771499-2151-1-git-send-email-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1444771499-2151-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 13, 2015 at 10:24:59PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> I forgot to add the requirement for the xfs_io command "falloc", which
> the test makes use of. Also fixed a weird indentation (mix of spaces
> and tabs) for one line of a comment.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Eryu Guan <eguan@redhat.com>
