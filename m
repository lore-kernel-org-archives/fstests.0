Received: from imap.thunk.org ([74.207.234.97]:33827 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbcBJX22 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Feb 2016 18:28:28 -0500
Date: Wed, 10 Feb 2016 18:28:26 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 05/12] xfstests: do not unmount tmpfs during remount
Message-ID: <20160210232826.GK26922@thunk.org>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-6-git-send-email-tytso@mit.edu>
 <20160210060716.GV19486@dastard>
 <20160210160732.GE26922@thunk.org>
 <20160210230700.GA19486@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210230700.GA19486@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, hughd@google.com, Junho Ryu <jayr@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 11, 2016 at 10:07:00AM +1100, Dave Chinner wrote:
> No, it's not really the options that are the problem here. The
> problem is -o remount vs unmount/mount and what the test is actually
> expecting.
> 
> I'd say "_scratch_remount" should do "-o remount" unconditionally
> (least surprise) and the current _scratch_remount should be changed
> to something like _scratch_cycle_mount(). That way both can take
> options, but it's clear they do different things. tmpfs can simply
> implement them the same way.

Well, I can do that, but it's going to be a huge patch --- the vast
majority of the calls to _scratch_remount in the tree (over 100) would
have to be changed to _scratch_cycle_mount, because they are just
doing a _scratch_umount / _scratch_mount without taking any arguments
to change the mount option.

It is this patch that adds the calls that is using -o remount to
change mount options for generic/003 and generic/306 and tmpfs.

This is why I suggested adding _scratch_change_mount_opts because it
changes the smallest number of things, and keeps _scratch_mount to
have the same semantic value.

But if you want me to sweep through the entire tree changing
_scratch_remount to _scratch_cycle_mount, I suppose I can do that.
It's not going to be a small patch, though......

						- Ted
