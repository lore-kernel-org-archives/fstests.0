Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:41685 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbbCYP1Q convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 25 Mar 2015 11:27:16 -0400
Date: Wed, 25 Mar 2015 11:27:13 -0400 (EDT)
From: Jan Tulak <jtulak@redhat.com>
Message-ID: <497845904.2655152.1427297233349.JavaMail.zimbra@redhat.com>
In-Reply-To: <alpine.LFD.2.00.1503251608001.16030@localhost.localdomain>
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com> <1427290055-32647-1-git-send-email-jtulak@redhat.com> <20150325144452.GH20767@twin.jikos.cz> <alpine.LFD.2.00.1503251608001.16030@localhost.localdomain>
Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits only.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: David Sterba <dsterba@suse.cz>, eguan@redhat.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

----- Original Message -----
> From: "David Sterba" <dsterba@suse.cz>
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
> 
> I've enforced this naming scheme for btrfs-progs userspace tests:
> https://github.com/kdave/btrfs-progs/tree/master/tests/fsck-tests
> 
> The preference might be different for others though, but we can still
> try to follow the scheme inside the tests/btrfs/ directory.
> 

I see the reason, but I have a note. This format breaks alphabetic ordering, so if we use names for grouping tests together, they are not listed that way. There is an example of what I mean by the grouping:

performance/group:
fsmark-small-files-001                fsmark small_files rw sequential
fsmark-small-files-002                fsmark small_files rw random
fsmark-small-files-003                fsmark small_files traverse
fsmark-small-files-004                fsmark small_files unlink
fsmark-large-files-001                fsmark large_files rw
fsmark-large-files-002                fsmark large_files unlink
fsmark-1m-empty-files-001        fsmark metadata scale create
fsmark-10m-empty-files-001        fsmark metadata scale create
fsmark-100m-empty-files-001        fsmark metadata scale create
fsmark-100m-empty-files-002        fsmark metadata scale traverse
fsmark-100m-empty-files-003        fsmark metadata scale unlink
.....

If we put the unique number at the end (some-name-NNN), then this issue is eliminated. Of course, with this you can't do NNN<tab> for completion, but it keeps the number reference. But this way it makes harder to find the test by number...


----- Original Message -----
> From: "Lukáš Czerner" <lczerner@redhat.com>
> Sent: Wednesday, 25 March, 2015 4:20:24 PM
> 
> 
> Yes, I like that, but then we want to make sure that we do not have
> tests with the same numbers, but different name. Also having more more
> constrains on the names is a good thing especially when people feel like
> being creative with test names.
> 
> So we can make it
> 
> NNN-test-name
> 
> where we only allow numbers in the first three characters, and only
> alphabetic ASCII characters and a dash afterwards (or underscore,
> whichever you prefer).
> 
> Thanks!
> -Lukas

The stricter rules are all right, I agree with that too.

Jan
