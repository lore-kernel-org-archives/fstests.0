Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43579 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239AbbCYPn1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 25 Mar 2015 11:43:27 -0400
Date: Wed, 25 Mar 2015 16:43:22 +0100 (CET)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits
 only.
In-Reply-To: <497845904.2655152.1427297233349.JavaMail.zimbra@redhat.com>
Message-ID: <alpine.LFD.2.00.1503251637110.16030@localhost.localdomain>
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com> <1427290055-32647-1-git-send-email-jtulak@redhat.com> <20150325144452.GH20767@twin.jikos.cz> <alpine.LFD.2.00.1503251608001.16030@localhost.localdomain>
 <497845904.2655152.1427297233349.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1709970685-1427298205=:16030"
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: David Sterba <dsterba@suse.cz>, eguan@redhat.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1709970685-1427298205=:16030
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 25 Mar 2015, Jan Tulak wrote:

> Date: Wed, 25 Mar 2015 11:27:13 -0400 (EDT)
> From: Jan Tulak <jtulak@redhat.com>
> To: Lukáš Czerner <lczerner@redhat.com>
> Cc: David Sterba <dsterba@suse.cz>, eguan@redhat.com, fstests@vger.kernel.org
> Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits only.
> 
> ----- Original Message -----
> > From: "David Sterba" <dsterba@suse.cz>
> > 
> > I have a proposal for slight modification to the naming scheme:
> > 
> >   NNN-free-text
> > 
> > where NNN is a unique number among all tests in the same directory.
> > 
> > Why? Convenience, a shortcut for the long test descriptions. We usually
> > say that test 123 fails and some other does not, I personally find it
> > very handy and would like to keep that.
> > 
> > I've enforced this naming scheme for btrfs-progs userspace tests:
> > https://github.com/kdave/btrfs-progs/tree/master/tests/fsck-tests
> > 
> > The preference might be different for others though, but we can still
> > try to follow the scheme inside the tests/btrfs/ directory.
> > 
> 
> I see the reason, but I have a note. This format breaks alphabetic ordering, so if we use names for grouping tests together, they are not listed that way. There is an example of what I mean by the grouping:
> 
> performance/group:
> fsmark-small-files-001                fsmark small_files rw sequential
> fsmark-small-files-002                fsmark small_files rw random
> fsmark-small-files-003                fsmark small_files traverse
> fsmark-small-files-004                fsmark small_files unlink
> fsmark-large-files-001                fsmark large_files rw
> fsmark-large-files-002                fsmark large_files unlink
> fsmark-1m-empty-files-001        fsmark metadata scale create
> fsmark-10m-empty-files-001        fsmark metadata scale create
> fsmark-100m-empty-files-001        fsmark metadata scale create
> fsmark-100m-empty-files-002        fsmark metadata scale traverse
> fsmark-100m-empty-files-003        fsmark metadata scale unlink
> .....
> 
> If we put the unique number at the end (some-name-NNN), then this issue is eliminated. Of course, with this you can't do NNN<tab> for completion, but it keeps the number reference. But this way it makes harder to find the test by number...
> 

First of all, what's the point of the names if they are the same ?
And secondly what's the point of numbers if they repeat so often ?

This is probably only relevant to your performance patches, but can
you elaborate a bit more on how you plan to name the tests ? Because I am
not sure the example you've just shown is the best approach.

Also is there a reason for you to see it grouped by the name when
you do ls ? It's not like it'll help you run a group of the tests at
once.

-Lukas


> 
> ----- Original Message -----
> > From: "Lukáš Czerner" <lczerner@redhat.com>
> > Sent: Wednesday, 25 March, 2015 4:20:24 PM
> > 
> > 
> > Yes, I like that, but then we want to make sure that we do not have
> > tests with the same numbers, but different name. Also having more more
> > constrains on the names is a good thing especially when people feel like
> > being creative with test names.
> > 
> > So we can make it
> > 
> > NNN-test-name
> > 
> > where we only allow numbers in the first three characters, and only
> > alphabetic ASCII characters and a dash afterwards (or underscore,
> > whichever you prefer).
> > 
> > Thanks!
> > -Lukas
> 
> The stricter rules are all right, I agree with that too.
> 
> Jan
> 
--8323328-1709970685-1427298205=:16030--
