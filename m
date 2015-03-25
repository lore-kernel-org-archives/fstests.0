Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42998 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932114AbbCYPU2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 25 Mar 2015 11:20:28 -0400
Date: Wed, 25 Mar 2015 16:20:24 +0100 (CET)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits
 only.
In-Reply-To: <20150325144452.GH20767@twin.jikos.cz>
Message-ID: <alpine.LFD.2.00.1503251608001.16030@localhost.localdomain>
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com> <1427290055-32647-1-git-send-email-jtulak@redhat.com> <20150325144452.GH20767@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-228785489-1427296689=:16030"
Content-ID: <alpine.LFD.2.00.1503251618330.16030@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: David Sterba <dsterba@suse.cz>
Cc: =?ISO-8859-2?Q?Jan_=ABul=E1k?= <jtulak@redhat.com>, eguan@redhat.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-228785489-1427296689=:16030
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LFD.2.00.1503251618331.16030@localhost.localdomain>

On Wed, 25 Mar 2015, David Sterba wrote:

> Date: Wed, 25 Mar 2015 15:44:52 +0100
> From: David Sterba <dsterba@suse.cz>
> To: Jan «ulák <jtulak@redhat.com>
> Cc: eguan@redhat.com, fstests@vger.kernel.org
> Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits only.
> 
> On Wed, Mar 25, 2015 at 02:27:35PM +0100, Jan «ulák wrote:
> > Tests can use any name now, not 3 digits only.
> > (e.g. a test can be named "tests/generic/some-name")
> 
> Good idea.
> 
> > The only limitation on a test name is no whitespace and no dot.
> 
> IMHO we don't need to be too creative, the limitations make sense.
> 
> I have a proposal for slight modification to the naming scheme:
> 
>   NNN-free-text
> 
> where NNN is a unique number among all tests in the same directory.
> 
> Why? Convenience, a shortcut for the long test descriptions. We usually
> say that test 123 fails and some other does not, I personally find it
> very handy and would like to keep that.

Yes, I like that, but then we want to make sure that we do not have
tests with the same numbers, but different name. Also having more more
constrains on the names is a good thing especially when people feel like
being creative with test names.

So we can make it

NNN-test-name

where we only allow numbers in the first three characters, and only
alphabetic ASCII characters and a dash afterwards (or underscore,
whichever you prefer).

Thanks!
-Lukas

> 
> I've enforced this naming scheme for btrfs-progs userspace tests:
> https://github.com/kdave/btrfs-progs/tree/master/tests/fsck-tests
> 
> The preference might be different for others though, but we can still
> try to follow the scheme inside the tests/btrfs/ directory.
> 
> Otherwise the patch looks ok to me.
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--8323328-228785489-1427296689=:16030--
