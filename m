Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0117413CA81
	for <fstests@vger.kernel.org>; Fri, 27 Sep 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727461982; cv=none; b=avmhrdX6HmM6Scbxq073yVuniOxRQt4nAlvmEpPKm1V+plJBgJLeDAksqJb/lBaBnoob6L1rjo3rrx3h/aldOZPK+qsMNIcysJLJQF6ng39OpGHTeU7NqlpqbomixAsnziptJbGaOdMiSUPs7jgvudTYvqgxKaJtG+4M0Wg/kn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727461982; c=relaxed/simple;
	bh=FLlS/knzr3hOov59YYLWE9kH245rSIxx5G3u3gWiieA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o20scF+54B7SwB+oVYPGiMJWamQ9iR1Z5XbfCXFKkCG8m1/tJAI61sX6JTlNo1qJgn8GSngJGOWjaaz+FJ+gs3th4uxiGPCI5nC98lRVSPbHQlhc2J+vTqMpWX7we2rUVzQ6F9pfmNLSNkqIUB0W6FnWH/EZ0HLshCfRbkmLGXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEx2Jmbj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEx2Jmbj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727461978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fwWy0daRhTuNh3g1LQQtSoyDTHsrpBddnZpkz63Rwc=;
	b=OEx2JmbjVe6WSgRT0PrNpqNhmtq3VXSPrSzc+TS820JjAdKLDSQt6p8C953OcIJeM764CC
	GARnfWZr2jZvm0h8Jt4bVNqQDxss/LEUiRvcAT6/nnA2OBKP1J708lIz51oNLy/+OJjsUL
	iQgFPgExZd+jpdf6UOZsyUSIJnBX7Zs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-XUrb_HSKN5OTpFIRN3DQWA-1; Fri,
 27 Sep 2024 14:32:55 -0400
X-MC-Unique: XUrb_HSKN5OTpFIRN3DQWA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 627501934C5E;
	Fri, 27 Sep 2024 18:32:54 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.70])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 366941954B0F;
	Fri, 27 Sep 2024 18:32:53 +0000 (UTC)
Date: Fri, 27 Sep 2024 14:34:02 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] fsx: add missing fallocate flag ifdefs
Message-ID: <Zvb6mviA9gVhdPWp@bfoster>
References: <20240926144147.106685-1-bfoster@redhat.com>
 <20240926144147.106685-3-bfoster@redhat.com>
 <20240926145028.GC21840@frogsfrogsfrogs>
 <ZvWD6SsfGJDisYP9@bfoster>
 <20240927054231.adwhqd2cyexfu3if@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZvagFdWEcffZs06i@bfoster>
 <20240927152537.GQ21877@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gJRmY3uG4ezAzu8j"
Content-Disposition: inline
In-Reply-To: <20240927152537.GQ21877@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--gJRmY3uG4ezAzu8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2024 at 08:25:37AM -0700, Darrick J. Wong wrote:
> On Fri, Sep 27, 2024 at 08:07:49AM -0400, Brian Foster wrote:
> > On Fri, Sep 27, 2024 at 01:42:31PM +0800, Zorro Lang wrote:
> > > On Thu, Sep 26, 2024 at 11:55:21AM -0400, Brian Foster wrote:
> > > > On Thu, Sep 26, 2024 at 07:50:28AM -0700, Darrick J. Wong wrote:
> > > > > On Thu, Sep 26, 2024 at 10:41:47AM -0400, Brian Foster wrote:
> > > > > > The various fallocate flags are mostly ifdef'd for backward
> > > > > > compatibility with the exception of the associated test_fallocate()
> > > > > > calls to verify functionality at runtime. I suspect the reason for
> > > > > > this was to avoid ifdef ugliness around having to clear the runtime
> > > > > > flag for each operation, but unfortunately this defeats the purpose
> > > > > > of the ifdef protection everywhere else.
> > > > > > 
> > > > > > Factor out the fallocate related test calls into a new helper and
> > > > > > add the appropriate ifdefs.
> > > > > > 
> > > > > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > > > > ---
> > > > > >  ltp/fsx.c | 59 ++++++++++++++++++++++++++++++++++++++++++-------------
> > > > > >  1 file changed, 45 insertions(+), 14 deletions(-)
> > > > > > 
> > > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > > index 677f8c9f..417743c5 100644
> > > > > > --- a/ltp/fsx.c
> > > > > > +++ b/ltp/fsx.c
> > > > > > @@ -2833,6 +2833,50 @@ __test_fallocate(int mode, const char *mode_str)
> > > > > >  #endif
> > > > > >  }
> > > > > >  
> > > > > > +void
> > > > > > +test_fallocate_calls(void)
> > > > > > +{
> > > > > > +	if (fallocate_calls)
> > > > > > +		fallocate_calls = test_fallocate(0);
> > > > > > +	if (keep_size_calls)
> > > > > > +		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> > > > > > +
> > > > > > +#ifdef FALLOC_FL_UNSHARE_RANGE
> > > > > > +	if (unshare_range_calls)
> > > > > > +		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> > > > > > +#else
> > > > > > +	unshare_range_calls = 0;
> > > > > > +#endif
> > > > > > +
> > > > > > +#ifdef FALLOC_FL_PUNCH_HOLE
> > > > > > +	if (punch_hole_calls)
> > > > > > +		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> > > > > > +#else
> > > > > > +	punch_hole_calls = 0;
> > > > > > +#endif
> > > > > > +
> > > > > > +#ifdef FALLOC_FL_ZERO_RANGE
> > > > > > +	if (zero_range_calls)
> > > > > > +		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
> > > > > > +#else
> > > > > > +	zero_range_calls = 0;
> > > > > > +#endif
> > > > > > +
> > > > > > +#ifdef FALLOC_FL_COLLAPSE_RANGE
> > > > > > +	if (collapse_range_calls)
> > > > > > +		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
> > > > > > +#else
> > > > > > +	collapse_range_calls = 0;
> > > > > > +#endif
> > > > > 
> > > > > The concept looks fine, but collapse and zero range have been in the
> > > > > kernel for a decade now, do we really need to have ifdef tests for them?
> > > > > 
> > > > 
> > > > Probably not.. but why even bother worrying about individual flags? The
> > > > insert and unshare flags have been around for 9 and 8 years
> > > > respectively, none of these were fully ifdef'd from the beginning, and
> > > > I'm not aware of anyone that has actually complained.
> > > > 
> > > > I'm not convinced that this patch matters for anybody in practice. I
> > > > included it just because it was simple enough to include the minimum
> > > > mechanical fix and I was slightly curious if somebody could come up with
> > > > a more elegant solution. In the spirit of being practical, maybe the
> > > > better approach here is to just remove the (at least the falloc flag
> > > > related) ifdefs entirely? We can always add them back if somebody
> > > > complains...
> > > 
> > > As this patch is still controversial, I'll merge the other one at first, to
> > > catch up the release of this week. We can talk this one later, if you still
> > > hope to have it :)
> > > 
> > 
> > Thanks. In thinking more about it.. my reasoning above was that it seems
> > like the value of these ifdefs is to avoid disruption when new
> > functionality is introduced, but at the same time the fstests user base
> > may not be necessarily all that interested in eternal backwards
> > compatibility for ancient runtimes, etc. Therefore, I wonder if it's
> > reasonable to have an (informal) expiration date for when we can clear
> > out some of this cruft to keep the code cleaner and more maintainable
> > going forward.
> > 
> > So I largely agree with Darrick's point, it's just that personally I'm
> > less interested in discussion over which fallocate flags to include or
> > not because to my mind that suggests we might as well just drop the
> > ifdefs entirely. That said, I'm not all that invested beyond just trying
> > to be proactive since I happened to be hacking in this area, so if you
> > guys want to leave things as is, or agree on a subset of flags to ifdef,
> > just let me know and I'll drop it or send a v2.
> 
> Usually I just let Christoph complain and remove the ifdefs, but if I
> have to use my own rule, it would be that ifdefs and ./configure
> trickery isn't necessary for any symbol that is at least 5 years old.
> 
> Recent complaints on the mailing list have caused me to revise that to
> 10 years old though (see recent memfd_create fixes). :)
> 
> I also remember that a lot of the old crufty ifdef stuff (iirc) was kept
> around so that fstests would continue to run on old RHELs.  Once in a
> while our QA folks rebase fstests to latest, but they also tend to patch
> back in whatever ./configure magic they need for 2.6 era kernels.
> 

That's kind of what I figured.. even if folks were running on old envs,
maybe there's enough incompatibility to work through in extreme enough
cases that customization is required anyways and we just don't hear
about it upstream.

Anyways, that all seems reasonable to me. Given that it looks like this
has been broken for the last 8+ years or so, attached is an alternative
proposal to slightly bend your 10 year rule in this case... ;).

As before, this is not much of a big deal to me either way. Zorro, this
kind of goes in the opposite direction of your comments to patch 1 where
I added the missing ifdefs, so I'd defer to you as to whether you want
to go this route or just leave things as is for the time being. The
attached patch also removes the ifdefs added in patch 1, so there should
be no need to edit patch 1 either way. Thanks.

Brian

> --D
> 
> > Brian
> > 
> > 
> > > Thanks,
> > > Zorro
> > > 
> > > > 
> > > > Brian
> > > > 
> > > > > --D
> > > > > 
> > > > > > +
> > > > > > +#ifdef FALLOC_FL_INSERT_RANGE
> > > > > > +	if (insert_range_calls)
> > > > > > +		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
> > > > > > +#else
> > > > > > +	insert_range_calls = 0;
> > > > > > +#endif
> > > > > > +}
> > > > > > +
> > > > > >  bool
> > > > > >  keep_running(void)
> > > > > >  {
> > > > > > @@ -3271,20 +3315,7 @@ main(int argc, char **argv)
> > > > > >  		check_trunc_hack();
> > > > > >  	}
> > > > > >  
> > > > > > -	if (fallocate_calls)
> > > > > > -		fallocate_calls = test_fallocate(0);
> > > > > > -	if (keep_size_calls)
> > > > > > -		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> > > > > > -	if (unshare_range_calls)
> > > > > > -		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> > > > > > -	if (punch_hole_calls)
> > > > > > -		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> > > > > > -	if (zero_range_calls)
> > > > > > -		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
> > > > > > -	if (collapse_range_calls)
> > > > > > -		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
> > > > > > -	if (insert_range_calls)
> > > > > > -		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
> > > > > > +	test_fallocate_calls();
> > > > > >  	if (clone_range_calls)
> > > > > >  		clone_range_calls = test_clone_range();
> > > > > >  	if (dedupe_range_calls)
> > > > > > -- 
> > > > > > 2.46.1
> > > > > > 
> > > > > > 
> > > > > 
> > > > 
> > > > 
> > > 
> > 
> 

--gJRmY3uG4ezAzu8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-fsx-remove-unnecessary-fallocate-flag-ifdefs.patch"

From 710f88a08a978c2c6ae2e9f92a35da08aa45db72 Mon Sep 17 00:00:00 2001
From: Brian Foster <bfoster@redhat.com>
Date: Fri, 27 Sep 2024 14:08:50 -0400
Subject: [PATCH] fsx: remove unnecessary fallocate flag ifdefs
Content-Type: text/plain

fallocate mode flags are typically ifdef'd when introduced to
provide some backwards compatibility and minimize disruption for
users who might not have picked up the latest supporting bits in
their dev and test environments. As it is, most of these flags have
been used outside of ifdef protection for runtime functionality
detection for quite some time, so this apparently hasn't been
providing much practical benefit.

fallocate runtime functionality detection goes back 8-10 years now
in some cases, without any known complaints upstream. Therefore,
clean out some of the older ifdef cruft as a housekeeping exercise.
This can be undone if it turns out to be problematic for any current
fstests users.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 ltp/fsx.c | 77 +++++--------------------------------------------------
 1 file changed, 7 insertions(+), 70 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 677f8c9f..db8ee914 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1231,7 +1231,6 @@ dotruncate(unsigned size)
 	}
 }
 
-#ifdef FALLOC_FL_PUNCH_HOLE
 void
 do_punch_hole(unsigned offset, unsigned length)
 {
@@ -1280,15 +1279,6 @@ do_punch_hole(unsigned offset, unsigned length)
 	memset(good_buf + max_offset, '\0', max_len);
 }
 
-#else
-void
-do_punch_hole(unsigned offset, unsigned length)
-{
-	return;
-}
-#endif
-
-#ifdef FALLOC_FL_ZERO_RANGE
 void
 do_zero_range(unsigned offset, unsigned length, int keep_size)
 {
@@ -1344,15 +1334,6 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
 	memset(good_buf + offset, '\0', length);
 }
 
-#else
-void
-do_zero_range(unsigned offset, unsigned length, int keep_size)
-{
-	return;
-}
-#endif
-
-#ifdef FALLOC_FL_COLLAPSE_RANGE
 void
 do_collapse_range(unsigned offset, unsigned length)
 {
@@ -1399,15 +1380,6 @@ do_collapse_range(unsigned offset, unsigned length)
 	file_size -= length;
 }
 
-#else
-void
-do_collapse_range(unsigned offset, unsigned length)
-{
-	return;
-}
-#endif
-
-#ifdef FALLOC_FL_INSERT_RANGE
 void
 do_insert_range(unsigned offset, unsigned length)
 {
@@ -1455,15 +1427,6 @@ do_insert_range(unsigned offset, unsigned length)
 	file_size += length;
 }
 
-#else
-void
-do_insert_range(unsigned offset, unsigned length)
-{
-	return;
-}
-#endif
-
-#ifdef XFS_IOC_EXCHANGE_RANGE
 int
 test_exchange_range(void)
 {
@@ -1546,20 +1509,6 @@ out_free:
 	free(p);
 }
 
-#else
-int
-test_exchange_range(void)
-{
-	return 0;
-}
-
-void
-do_exchange_range(unsigned offset, unsigned length, unsigned dest)
-{
-	return;
-}
-#endif
-
 #ifdef FICLONERANGE
 int
 test_clone_range(void)
@@ -1897,12 +1846,10 @@ do_preallocate(unsigned offset, unsigned length, int keep_size, int unshare)
 		opflags |= FL_KEEP_SIZE;
 		mode |= FALLOC_FL_KEEP_SIZE;
 	}
-#ifdef FALLOC_FL_UNSHARE_RANGE
 	if (unshare) {
 		opflags |= FL_UNSHARE;
 		mode |= FALLOC_FL_UNSHARE_RANGE;
 	}
-#endif
 
         if (length == 0) {
                 if (!quiet && testcalls > simulatedopcount)
@@ -2495,11 +2442,9 @@ usage(void)
 	-q: quieter operation\n\
 	-r readbdy: 4096 would make reads page aligned (default 1)\n\
 	-s style: 1 gives smaller truncates (default 0)\n\
-	-t truncbdy: 4096 would make truncates page aligned (default 1)\n"
-#ifdef FALLOC_FL_UNSHARE_RANGE
-"	-u Do not use unshare range\n"
-#endif
-"	-w writebdy: 4096 would make writes page aligned (default 1)\n\
+	-t truncbdy: 4096 would make truncates page aligned (default 1)\n\
+	-u Do not use unshare range\n\
+	-w writebdy: 4096 would make writes page aligned (default 1)\n\
 	-x: preallocate file space before starting, XFS only\n\
 	-y: synchronize changes to a file\n"
 
@@ -2513,18 +2458,10 @@ usage(void)
 #ifdef HAVE_LINUX_FALLOC_H
 "	-F: Do not use fallocate (preallocation) calls\n"
 #endif
-#ifdef FALLOC_FL_PUNCH_HOLE
-"	-H: Do not use punch hole calls\n"
-#endif
-#ifdef FALLOC_FL_ZERO_RANGE
-"	-z: Do not use zero range calls\n"
-#endif
-#ifdef FALLOC_FL_COLLAPSE_RANGE
-"	-C: Do not use collapse range calls\n"
-#endif
-#ifdef FALLOC_FL_INSERT_RANGE
-"	-I: Do not use insert range calls\n"
-#endif
+"	-H: Do not use punch hole calls\n\
+	-z: Do not use zero range calls\n\
+	-C: Do not use collapse range calls\n\
+	-I: Do not use insert range calls\n"
 #ifdef FICLONERANGE
 "	-J: Do not use clone range calls\n"
 #endif
-- 
2.46.1


--gJRmY3uG4ezAzu8j--

