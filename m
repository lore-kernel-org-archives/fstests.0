Return-Path: <fstests-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60834 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128AbbCYOoy (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 25 Mar 2015 10:44:54 -0400
Date: Wed, 25 Mar 2015 15:44:52 +0100
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits only.
Message-ID: <20150325144452.GH20767@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com>
 <1427290055-32647-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1427290055-32647-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan =?utf-8?B?xaR1bMOhaw==?= <jtulak@redhat.com>
Cc: eguan@redhat.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 25, 2015 at 02:27:35PM +0100, Jan Ťulák wrote:
> Tests can use any name now, not 3 digits only.
> (e.g. a test can be named "tests/generic/some-name")

Good idea.

> The only limitation on a test name is no whitespace and no dot.

IMHO we don't need to be too creative, the limitations make sense.

I have a proposal for slight modification to the naming scheme:

  NNN-free-text

where NNN is a unique number among all tests in the same directory.

Why? Convenience, a shortcut for the long test descriptions. We usually
say that test 123 fails and some other does not, I personally find it
very handy and would like to keep that.

I've enforced this naming scheme for btrfs-progs userspace tests:
https://github.com/kdave/btrfs-progs/tree/master/tests/fsck-tests

The preference might be different for others though, but we can still
try to follow the scheme inside the tests/btrfs/ directory.

Otherwise the patch looks ok to me.
